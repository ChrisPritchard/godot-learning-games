use godot::{engine::ICanvasLayer, prelude::*};

#[derive(GodotClass)]
#[class(base=CanvasLayer)]
struct UserInterface {}

#[godot_api]
impl ICanvasLayer for UserInterface {
    fn init(_base: Base <Self::Base>) -> Self {
        Self {}
    }
}