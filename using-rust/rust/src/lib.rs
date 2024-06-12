use godot::prelude::*;

struct RustExtension;

mod player; // this is not in the tutorial, 
// but if not present player.rs will not be compiled and so things wont work. rust-analyser also needs this

#[gdextension]
unsafe impl ExtensionLibrary for RustExtension {}