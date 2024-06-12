# Using Rust

An implementation of the hello-world example here: https://godot-rust.github.io/book/intro/hello-world.html

Overall, the setup is not too difficult:

- the rust project needs to be compiled as a dynamic library and reference the github project (later a crate), as seen in [Cargo.toml](./rust/Cargo.toml)
- it needs to contain a class that implements [ExtensionLibrary](https://godot-rust.github.io/docs/gdext/master/godot/init/trait.ExtensionLibrary.html), as seen here in [lib.rs](./rust/src/lib.rs)
- godot needs to know about the extension and where to find the compiled binaries, via a [.gdextension file](./godot/rust.gdextension)
- how various things are used depends on what they are, but a script for example is not 'attached' but instead forms a new node type, e.g. [Player](./rust/src/player.rs) which is a type of Sprite2D - in godot any node can be made to use the script by using the 'change type' function.

Not too cumbersome, but a bit like C# and other languages in that every change needs a recompile before godot will pick it up; contrast with GDScript which updates in real time (and is far, far more lightweight to write in than these other languages). Fortunately, Godot has no restriction on mixing and matching - GDScript + Rust is completely viable.

> also, pro tip, rust-analyzer can be configured via 'linkedProjects' to pick up a rust project in a sub directory, so you can maintain both godot and rust in one vscode session if you so wish.
