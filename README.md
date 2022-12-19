# PlaydateSequence

[![Lua Version](https://img.shields.io/badge/Lua-5.4-yellowgreen)](https://lua.org) [![Toybox Compatible](https://img.shields.io/badge/toybox.py-compatible-brightgreen)](https://toyboxpy.io) [![Latest Version](https://img.shields.io/github/v/tag/NicMagnier/PlaydateLDtkImporter)](https://github.com/NicMagnier/PlaydateLDtkImporter/tags)

Create animations with simple sequences of easing functions in your playdate game

## How to use sequence.lua on Playdate

#### Using toybox.py

You can add it to your **Playdate** project by installing [**toybox.py**](https://toyboxpy.io), going to your project folder in a Terminal window and typing:

```console
toybox add Sequence
toybox update
```

Then, if your code is in the `source` folder, just import the following:

```lua
import '../toyboxes/toyboxes.lua'
```

#### Manually

You first need to copy the file `sequence.lua` in your playdate project and to import it

```lua
import 'sequence'
```

### Creating animations

#### Chain easing functions
The main idea of sequence.lua is to easily have multiple easing functions play one after the other. To create an animation you simply chain multiple transitions:
```lua
local cool_animation = sequence.new():from(0):to(10, 0.3, "outCirc"):sleep(0.4):to(0, 0.5, "outExpo"):start()
```

Let's disconstruct this animation:

- `sequence.new()` is creating a new sequence object
- `:from(0)` is setting the initial value of the animation to 0
- `:to(10, 0.3, "outCirc")` is telling the value to go to 10 in 0.3 seconds using the easing outCirc
- `:sleep(0.4)` is telling to keep the value the same for 0.4 seconds
- `:to(0, 0.5, "outExpo")` is telling the value to go to 0 in 0.5 seconds using the easing outExpo
- `:start()` is starting to play the animation immediatly

You can also add `:loop()` so that the animation will loop indefinitely or `:mirror()` to loop the animation back and forth.

#### Update Loop
For the animation to be updated properly, you need also to call `sequence.update()` in your update function
```lua
function playdate.update()
	sequence.update()
  
  -- Your code ...
end
```

And to get the current value of the animation, you can simply call `:get()` on the sequence
```lua
local position_x = cool_animation:get()
```

#### Control the animation
You don't have to call `:start()` when you declare the animation. You can just start it when an event happens in your game. You can also call `:pause()` `:stop()` or `:restart()` to control when the animation is played in your code.

#### Callbacks
If you want to play a sound at specific points in the animation (or trigger other effects or gameplay feature) you can use `:callback()` in your sequence.

```lua
sequence.new():from(0):to(69, 4.2, "flat"):callback(function() print("Noice") end)
```

#### Best practice

- When an animation is played in loop, it will be played forever even if you delete the animation unless you call `:stop()` or `:pause()`. The sequence system has a reference to the animation to know when to update it and as such, the animation cannot be deleted it by the garbage collector even when you dereference it.
- To avoid creating object at run time, it is better to create your sequences at initialization (at boot or on level load) and to play them when needed.

