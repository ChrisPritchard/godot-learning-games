use godot::{engine::IRigidBody2D, prelude::*};

#[derive(GodotClass)]
#[class(base=RigidBody2D)]
struct Creep {}

#[godot_api]
impl IRigidBody2D for Creep {
    fn init(_base: Base <Self::Base>) -> Self {
        Self {}
    }
}