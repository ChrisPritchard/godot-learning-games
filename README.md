# Godot Learning Games

Games I have made while learning [Godot](https://godotengine.org/) (pronounced 'GOD OH' - I need to practice this)

In the repo root, these are godot 4 projects built when I came back to the engine.

- [using-rust](./using-rust/) is the hello-world demo of [godot-rust](https://godot-rust.github.io/), a set of rust libraries that allow use of rust as a scripting language. While a bit of a pain to set up, scripts built in such a way (binding to the GDExtension api) can run much faster than GDScript or C#, and so its a good candidate for code that needs to belt away, e.g. AI or other computationally intensive stuff.

- [(gd4) dodge-the-creeps](./dodge-the-creeps-gd/), the first 2d game tutorial in the docs, done again but more independently by me in gd4. in gdscript

## Godot 3 Project Details

The first time I played with godot, where godot 3 was the current stable

> For these I have elected to use **GDScript** as the primary language, as opposed to **C#** or something using **GDNative**/**GDExtension** (e.g. Go, Rust). Reasoning being that while I am a very proficient C# developer, I enjoy learning something new. GDScript seems a little cleaner, better documented, more popular, and so ticks all the boxes.

- [(gd3) dodge-the-creeps](./old-godot3/dodge-the-creeps/) is based on the [your first 2D game tutorial](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html). I managed to make it in around an 70 minutes (an hour 10), showing the simplicity of the engine, given this was the first time I had ever used Godot.

The next few projects all come from the Pakt Publishing book: https://www.packtpub.com/product/godot-engine-game-development-projects/9781788831505. Building these are useful as they are for a slightly older version of Godot (3.0), meaning I needed to tweak and update as we go (as I used 3.44 then 3.5). I recommend the book; its a great learning resource.

- [coin-dash](./old-godot3/coin-dash/) is very similar to the 2D game tutorial - but chasing coins rather than avoiding creeps. It has a little more complexity (powerups for example, and obstacles) but is basically the same game.

- [escape-the-maze](./old-godot3/escape-the-maze/) contains examples of inheritance, tilemap usage and a global autoload. One way this tutorial deviated from the book was that the way you create tilesets is more sophisticated as of Godot 3.4.4 - instead of making a bunch of sprites and then exporting, the tileset creation tool with its atlas and single tile editors made this quick and easy - though it did cause me to add colliders to something in error, which stumped me for a few days when I couldn't enter coin tiles for example.

- [space-rocks](./old-godot3/space-rocks/) is a asteroids-type game, and explores 2D physics. some spawning mechanics around rocks, enemies, bullets etc are interesting. otherwise its fairly simple.

- [jungle-jump](./old-godot3/jungle-jump/) is a platformer. It includes jumping, climbing ladders, moving platforms, enemies that reverse direction when finding objects, spike traps, collectibles etc etc. All the bits of a standard platformer, including multiple levels. The use of animation players, parralax backgrounds and more physics work than prior projects was fun. 

This was the last (ultimate) 2D project in the Pakt book and penultimate overall - the next and last chapter covered making a 3D game which I read through but did not have much interest in making at this point in my learning journey (I find 2D more attractive as a style for the moment).