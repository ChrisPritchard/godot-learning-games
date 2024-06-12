use godot::prelude::*;

struct RustExtension;

mod player;

#[gdextension]
unsafe impl ExtensionLibrary for RustExtension {}