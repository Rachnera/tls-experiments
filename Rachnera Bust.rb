module Busty
  # All actual configuration "CONSTANTS" can be found in the "Bust Config" file. Just dropping empty shells here for reference.
  BASE_CONFIG = {} # Make the face fits right on the body
  FACE_TO_BUST = {} # For characters whose naming convention of their faces isn't consistent with the name of their bust
  SUBSET_TO_BUST = [] # For busts matching with only some of the faces of a facesheet

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
    return matches[2] if matches

    /\A([a-zA-Z]\s+)?(.+)\Z/.match(face_name)[2] # Will effectively return the name in full if nothing else works
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

      @bust_overflow = Sprite.new
      @bust_overflow.visible = true
      @bust_overflow.z = @bust.z
    end

    def draw(x, y, face_name, face_index, max_width = nil, above_height = nil)
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
      face_width = 96 - face_border_width_left - face_border_width_right
      face_height = 96 - face_border_width_top - face_border_width_bottom

      extra = 0
      if max_width
        # Cut part of the face if that would make the image overflows to the right
        extra = (face_offset_x + face_border_width_left + face_border_width_right + face_width) - max_width
        face_width -= extra if extra > 0
      end

      bitmap = Cache.face(face_name)
      rect = Rect.new(
        face_index % 4 * 96 + face_border_width_left,
        face_index / 4 * 96 + face_border_width_top,
        face_width,
        face_height
      )
      face_bitmap = Bitmap.new(face_width, face_height)
      face_bitmap.blt(0, 0, bitmap, rect)
      @bust_face.bitmap = face_bitmap
      @bust_face.x = @bust.x + face_border_width_left + face_offset_x
      @bust_face.y = @bust.y + face_border_width_top + face_offset_y
      @bust_face.z = @bust.z + face_z

      @bust_overflow.bitmap = nil
      return unless above_height
      # Next part is only relevant if the bust was cut
      return unless max_width
      # Also skip if the face is so close to the right we had to cut it
      return if extra > 0

      extra_width = bust_bitmap.width - @bust.width
      extra_height = Graphics.height - above_height - @bust.y
      return unless extra_width > 0 && extra_height > 0

      extra_bitmap = Bitmap.new(extra_width, extra_height)
      extra_rect = Rect.new(@bust.width, 0, extra_width, extra_height)
      extra_bitmap.blt(0, 0, bust_bitmap, extra_rect)

      @bust_overflow.x = @bust.x + @bust.width
      @bust_overflow.y = @bust.y
      @bust_overflow.bitmap = extra_bitmap
    end

    def redraw(face_name, face_index)
      draw(@bust.x, @bust.y - Graphics.height + @bust.height, face_name, face_index)
    end

    def erase
      @bust.bitmap = nil
      @bust_face.bitmap = nil
      @bust_overflow.bitmap = nil
    end

    def update
      @bust.update
      @bust_face.update
      @bust_overflow.update
    end

    def dispose
      @bust.dispose
      @bust.bitmap.dispose if !@bust.bitmap.nil?

      @bust_face.dispose
      @bust_face.bitmap.dispose unless @bust_face.bitmap.nil?

      @bust_overflow.dispose
      @bust_overflow.bitmap.dispose if @bust_overflow.bitmap
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
      w = bust_config[:face_border_width]

      return w if w.kind_of?(Array)

      return [0, 0, 0, 0] if w.nil?

      [w, w, w, w]
    end

    def face_border_width_top
      face_border_width[0]
    end

    def face_border_width_right
      face_border_width[1]
    end

    def face_border_width_bottom
      face_border_width[2]
    end

    def face_border_width_left
      face_border_width[3]
    end

    def face_z
      bust_config[:face_z] || +1
    end

    def bust_config
      Busty::BASE_CONFIG[character_name] || {}
    end
  end
end
