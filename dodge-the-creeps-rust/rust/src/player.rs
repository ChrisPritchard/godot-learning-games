use godot::{engine::{AnimatedSprite2D, Area2D, IArea2D}, prelude::*};

enum Direction { Left, Right, Up, Down }

#[derive(GodotClass)]
#[class(base=Area2D,no_init)]
struct Player {
    speed: f32,
    screen_size: Vector2,
    direction: Direction,

    base: Base<Area2D>
}

#[godot_api]
impl IArea2D for Player {
    fn ready(&mut self) {
        self.speed = 400.;
        self.screen_size = self.base().get_viewport_rect().size;
        self.direction = Direction::Right;
    }

    fn physics_process(&mut self, delta: f64) {
        godot_print!("Hello, world!");

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
            velocity = velocity.normalized() * self.speed;
            let screen_size = self.screen_size;
            let mut node = self.base_mut();
            let position = node.get_position() + velocity * delta as f32;
            node.set_position(position + position.clamp(Vector2::ZERO, screen_size));
            animation_player.play();
        } else {
            animation_player.stop()
        }
    }
}