## Initial setup

For any of the busts related features to work, you first need to do the following (once).

Add the following scripts to your project:
- Rachnera Bust
- Bust Config

Drop the `Graphics/` folder to the root of your project. This will do two things:
- Create a `busts/` folder (under `Pictures/`) with all the properly resized (and sometimes altered) busts ready for display.
- Update a few facesets (e.g. Simon, Orcent) and sprites (Hester) for consistency.

That folder also contains some other new and updated assets to match the bust system, including the corresponding full-size busts.

## Manually show a bust

Using the "Script" Event Command:

### Display

```rb
$some_bust = Busty::Bust.new(z = 0)
$some_bust.draw(
  x = 140,
  y = -120,
  face_name = "Tertia emo",
  face_index = 2
)
```

Note: To accomodate with the fact busts tend to be snapped to the bottom, y = 0 corresponds with the bottom of the bust aligned with the bottom of the screen. Axis are however unchanged, hence the minus sign.

### Change expression

Shortcut if you just need to change the character's expression without moving anything else.

```rb
$some_bust.redraw(
  face_name = "Tertia emo",
  face_index = 7
)
```

### Dispose

```rb
$some_bust.erase
$some_bust.dispose
$some_bust = nil
```

## Automatically show busts for dialogues

Add the following script before `Bust Config`, and preferably below other scripts modifying the text box:
- Rachnera Message Bust

If you one day wish to remove that feature but not other bust related ones, just delete that one script.

## Credits

Code by Rachnera
Inspired by [Hollow's Simple Message Busts](https://forums.rpgmakerweb.com/index.php?threads/simple-message-busts.45897/)
Configuration and image retouches by Decarabia and Lamsey
