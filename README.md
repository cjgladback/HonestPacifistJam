# Turn the Other Chick
 Creating a three legged race game for the fourth Honest Jam, aka The Pacifist Jam.
 My goal is to get a menu, some unusual but smooth movement in 3D, and a successful build. These are three things I have not accomplished previously, so. We'll see.
---
### To Do
- [] Make bird boxes move along ground
- [] Make camera follow bird boxes' center, facing down the track, with damping (based on bird center position along track? in case we want to run backward sometimes?)
- [] Limit bird boxes' distance from each other and lerp back into each other after number of seconds (based on amount of distance? slow when snapping back from the high end of distance?)
- [] Make bird boxes slow progressively in certain collisions and bounce off others to stop
- [] Separate bird boxes collisions--one should slow and cause the unit to turn, the rope between should hit only obstacles of a certain height, but either bird or rope hitting an obstacle that they bounce off should stop the unit not send it spinning.
- [] Menu with controls and start button
- [] Sound settings
- [] Basic bird models
- [] Dynamic rope (two or more cylinders connecting birds, thinner when further apart)
- [] Obstacle models
- [] Run cycles (speeding up and blending more with a more intense, leaned forward run when they get closer to full speed)
- [] Lighting
- [] Speed line VFX for close to full speed
- [] Bonk animation
- [] Textures
- [] Cutscene thumbnails
- [] Cutscene paintings
- [] Godot cutscene animations
- [] Level designs
- [] Menu level select
- [] Timer (save high scores? display high scores on levels?)
- [] Speed mode

### Hierarchy
- Menu
  - Play
  - Speed Mode (auto skips story; if 3,2,1 start is good for normal game flow, it's skipped here, too. if I get a timer working, it would be best looking if it didn't show until after each level, when you have the chance to breathe before advancing to the next level but speed mode would be best showing on screen during and auto-advancing, to show all completed times at the end. Maybe with full game time, including quick restarts, as well.)
  - Level Select
  - Sound Settings
  - Controls (probably just an image, but ideally with actual fetched labels from the key positions)
    - L controls:
      - Move left: X
      - Move right: C
      - Brake: Z
    - R controls:
      - Move left: M
      - Move right: <,
      - Brake: >.
    - Jump: Space
    - Cutscene advance: Space
    - Cutscene skip: Enter (or would left Tab be better?)
    - Quick restart: B
    - Pause (if I can manage it)/Return to menu: Escape
- Play
  - Cutscene (arrow forward through each storyboard moment and separate key to skip all)
  - First level: straight forward downhill, central obstacles to jump or dodge
  - middle levels with increasing obstacles, curves forcing coordination, and narrower paths forcing timed separations around central obstacles (two keys at once, especially with Space added for jumps over taller ones, might be too much for less expensive keyboards)
  - Final level is through a cat shrine/sanctuary/tree house with many tight curves (and gaps? if I allow them to fall, ideally I'd have to figure out how to animate them dramatically climbing back onto the track, like action heroes after rolling off a cliff to their Certain Doom, otherwise just a very quick fade to and from black with them back on the track somewhere they aren't soft locked) to get back home
  - End cutscene (Final version: would be good if they got less and less fluffy on each level, so they're not grounded when they get home.)
    - Their feet landing
    - Parents greeting them all worried
    - Pan down the untied ropes to the family photo with the kids flexing their single muscly wings?
