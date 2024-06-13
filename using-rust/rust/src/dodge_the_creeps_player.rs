// an example of how player.gd from dodge-the-creeps might look in rust

use godot::{engine::{AnimatedSprite2D, Area2D, CollisionShape2D, IArea2D}, prelude::*};

#[derive(PartialEq)]
enum Direction { Left, Right, Up, Down }

#[derive(GodotClass)]
#[class(base=Area2D)]
struct Player {
    speed: f32,
    screen_size: Vector2,
    direction: Direction,

    base: Base<Area2D>
}

#[godot_api]
impl IArea2D for Player {
    fn init(base: Base<Area2D>) -> Self {
        Self {
            speed: 400.,
            screen_size: Vector2::ZERO,
            direction: Direction::Right,

            base
        }
    }

    fn ready(&mut self) {
        self.screen_size = self.base().get_viewport_rect().size;
        // self.base().hide();
    }

    fn physics_process(&mut self, delta: f64) {
        let mut velocity = Vector2::ZERO;
        let input = Input::singleton();

        if input.is_action_pressed("ui_left".into()) {
            velocity.x -= 1.;
            self.direction = Direction::Left;
        }

        if input.is_action_pressed("ui_right".into()) {
            velocity.x += 1.;
            self.direction = Direction::Right;
        }

        if input.is_action_pressed("ui_up".into()) {
            velocity.y -= 1.;
            self.direction = Direction::Up;
        }

        if input.is_action_pressed("ui_down".into()) {
            velocity.y += 1.;
            self.direction = Direction::Down;
        }

        let mut animation_player = self.base().get_node_as::<AnimatedSprite2D>("AnimatedSprite2D");

        if velocity.length() > 0. {
            let animation = if self.direction == Direction::Right || self.direction == Direction::Left { "walk" } else { "up" };
            animation_player.set_animation(animation.into());
            animation_player.set_flip_v(self.direction == Direction::Down);
            animation_player.set_flip_h(self.direction == Direction::Left);

            velocity = velocity.normalized() * self.speed;
            let screen_size = self.screen_size;
            let mut node = self.base_mut();
            let position = node.get_position() + velocity * delta as f32;
            node.set_position(position.clamp(Vector2::ZERO, screen_size));

            animation_player.play();
        } else {
            animation_player.stop()
        }
    }
}

#[godot_api]
impl Player {
    #[func]
    fn collision_entered(&mut self) {
        self.base().get_node_as::<CollisionShape2D>("CollisionShape2D").set_deferred("disabled".into(), Variant::from(true));
        self.base_mut().hide();
    }    
}