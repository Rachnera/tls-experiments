# Inspired by https://forums.rpgmakerweb.com/index.php?threads/simple-message-busts.45897/
module Busty
  # All configuration "CONSTANTS" can be found in the "Bust Config" file

  def self.has_bust?(character_name)
    BASE_CONFIG.has_key?(character_name)
  end

  def self.character_from_face(face_name, face_index)
    return nil if face_name.empty?

    special = SUBSET_TO_BUST.find do |cf|
      cf[:face_name] == face_name && cf[:face_indexes].include?(face_index)
    end
    return special[:character_name] if special

    return FACE_TO_BUST[face_name] if FACE_TO_BUST.has_key?(face_name)

    matches = /\A([a-zA-Z]\s+)?(.+)\s+emo(.*)?\Z/.match(face_name)

    return nil unless matches

    matches[2]
  end

  def self.rescale_bitmap(bitmap, scale)
    width = bitmap.width * scale
    height = bitmap.height * scale
    new_bitmap = Bitmap.new(width, height)
    src_rect = Rect.new(0, 0, bitmap.width, bitmap.height)
    dest_rect = Rect.new(0, 0, width, height)
    # Ref: https://www.rubydoc.info/gems/openrgss/Bitmap#stretch_blt-instance_method
    new_bitmap.stretch_blt(dest_rect, bitmap, src_rect)
    bitmap.dispose
    new_bitmap
  end

  class Bust
    def initialize(z)
      @bust = Sprite.new
      @bust.visible = true
      @bust.z = z

      @bust_face = Sprite.new
      @bust_face.visible = true
    end

    def draw(x, y, face_name, face_index, max_width = nil)
      character_name = Busty::character_from_face(face_name, face_index)
      @character_name = character_name

      bitmap = bust_bitmap
      if max_width
        max_width = max_width-x if x < 0 # Ignore offscreen overflow

        new_bitmap = Bitmap.new(max_width, bust_bitmap.height)
        rect = Rect.new(0, 0, max_width, bust_bitmap.height)
        new_bitmap.blt(0, 0, bust_bitmap, rect)
        bitmap = new_bitmap
      end

      @bust.bitmap = bitmap
      @bust.x = x
      @bust.y = Graphics.height - @bust.height + y # A little unorthodox, but busts are snapped to the _lower_ left corner when y=0

      # Shave border of face image if need be
      border_width = face_border_width
      face_width = 96 - 2*border_width

      if max_width
        # Cut part of the face if that would make the image overflows to the right
        extra = (face_offset_x + border_width + face_width) - max_width
        face_width -= extra if extra > 0
      end

      bitmap = Cache.face(face_name)
      rect = Rect.new(face_index % 4 * 96 + border_width, face_index / 4 * 96 + border_width, face_width, 96 - 2*border_width)
      face_bitmap = Bitmap.new(face_width, 96 - 2*border_width)
      face_bitmap.blt(0, 0, bitmap, rect)
      @bust_face.bitmap = face_bitmap
      @bust_face.x = @bust.x + border_width + face_offset_x
      @bust_face.y = @bust.y + border_width + face_offset_y
      @bust_face.z = @bust.z + face_z
    end

    def redraw(face_name, face_index)
      draw(@bust.x, @bust.y - Graphics.height + @bust.height, face_name, face_index)
    end

    def erase
      @bust.bitmap = nil
      @bust_face.bitmap = nil
    end

    def update
      @bust.update
      @bust_face.update
    end

    def dispose
      @bust.dispose
      @bust.bitmap.dispose if !@bust.bitmap.nil?

      @bust_face.dispose
      @bust_face.bitmap.dispose unless @bust_face.bitmap.nil?
    end

    def bust_bitmap
      #TODO Very basic pseudo cache, can likely be improved (or at least cleaned up)
      @busts = {} if @busts.nil?
      return @busts[character_name] if @busts.has_key?(character_name)

      begin
        @busts[character_name] = Cache.picture('busts/' + character_name)
      rescue
        @busts[character_name] = Busty::rescale_bitmap(Cache.picture(character_name), bust_scale)
      end

      @busts[character_name]
    end

    def character_name
      @character_name
    end

    def bust_scale
      bust_config[:bust_scale] || 0.75
    end

    def face_offset_x
      bust_config[:face_offset_x] || 60
    end

    def face_offset_y
      bust_config[:face_offset_y] || 40
    end

    def face_border_width
      bust_config[:face_border_width] || 0
    end

    def face_z
      bust_config[:face_z] || +1
    end

    def bust_config
      Busty::BASE_CONFIG[character_name] || {}
    end
  end
end
