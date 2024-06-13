use godot::{engine::IArea2D, prelude::*};

#[derive(GodotClass)]
#[class(base=Area2D)]
struct Player {}

#[godot_api]
impl IArea2D for Player {
    fn init(_base: Base <Self::Base>) -> Self {
        Self {}
    }
}