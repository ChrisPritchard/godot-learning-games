use godot::prelude::*;

#[derive(GodotClass)]
#[class(base=Node)]
struct MainScene {}

#[godot_api]
impl INode for MainScene {
    fn init(_base: Base <Self::Base>) -> Self {
        Self {}
    }
}