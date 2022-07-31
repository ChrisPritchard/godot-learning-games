# Godot Learning Games

Games I have made while learning [Godot](https://godotengine.org/) (pronounced 'GOD OH' - I need to practice this)

> For these I have elected to use **GDScript** as the primary language, as opposed to **C#** or something using **GDNative** (e.g. Go). Reasoning being that while I am a very proficient C# developer, I enjoy learning something new. GDScript seems a little cleaner, better documented, more popular, and so ticks all the boxes.

## Project details

- [dodge-the-creeps](./dodge-the-creeps/) is based on the [your first 2D game tutorial](https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html). I managed to make it in around an 70 minutes (an hour 10), showing the simplicity of the engine, given this was the first time I had ever used Godot.

The next few projects all come from the Pakt Publishing book: https://www.packtpub.com/product/godot-engine-game-development-projects/9781788831505. Building these are useful as they are for a slightly older version of Godot, meaning I needed to tweak and update as we go. I recommend the book; its a great learning resource.

- [coin-dash](./coin-dash/) is very similar to the 2D game tutorial - but chasing coins rather than avoiding creeps. It has a little more complexity (powerups for example, and obstacles) but is basically the same game.

- [escape-the-maze](./escape-the-maze/) contains examples of inheritance, tilemap usage and a global autoload. One way this tutorial deviated from the book was that the way you create tilesets is more sophisticated as of Godot 3.4.4 - instead of making a bunch of sprites and then exporting, the tileset creation tool with its atlas and single tile editors made this quick and easy - though it did cause me to add colliders to something in error, which stumped me for a few days when I couldn't enter coin tiles for example.

- [space-rocks](./space-rocks/) is a asteroids-type game, and explores 2D physics. some spawning mechanics around rocks, enemies, bullets etc are interesting. otherwise its fairly simple.