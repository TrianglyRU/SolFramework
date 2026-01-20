# What is this?
This is a director's cut / fork of the [Orbinaut Framework 2](https://github.com/TrianglyRU/OrbinautFramework).

# Is it different?
Yes and no. The core idea and overall presentation remain the same, but several modifications have been made:
- The animation system now supports more features from the original Mega Drive engine.
- The rendering system has been overhauled: shaders are now separated, and palette and fade effects are applied at the camera level rather than per sprite.
- The background and distortion systems have been reworked, allowing for greater flexibility and fewer limitations.
- Tile collision now introduces a common layer that objects always collide with, along with automatically calculated angles, and the three-tile-type system has been replaced by marker layers.
- Player-to-solid-object collision has been rewritten for perfect accuracy, and basic object-to-object collision now uses GameMaker’s built-in collision mask system.
- All framework modules have been flattened and are now direct properties of the controller itself.
- The organization of methods (function variables) has been reworked.
- Function names and descriptions have been updated.
- The entire codebase has been reviewed, with slight changes to the coding style.

# For what GameMaker version is this for?
Latest available **LTS** (Long-Term Stable) build only. Due to the absence of certain features, like native track looping support, some parts of the code are either missing or temporarily rewritten.

# Is there documentation or support?
No, and there won't be. This is a personal modification I made for myself, but decided to share with others. Therefore, I am not accepting any bug reports and/or feature requests. The framework is provided 'as is'.

# So, is it stable then? What about updates?
Based on my tests, core framework systems are stable and work as intended. The main branch of this repository may (and will) be updated without notice according to my needs or upon discovery of bugs and issues, but no more than once a week.

# How can I download it?
Click `Code` -> `Download ZIP` or clone it with your git CLI or client.
