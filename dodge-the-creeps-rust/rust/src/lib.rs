use godot::prelude::*;

struct RustExtension;

#[gdextension]
unsafe impl ExtensionLibrary for RustExtension {}

mod player;
mod user_interface;
mod creep;
mod main_scene;