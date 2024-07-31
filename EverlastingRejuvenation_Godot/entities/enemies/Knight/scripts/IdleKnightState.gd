class_name IdleKnightState extends State

const SPEED : float = 15;

func Enter() -> void:
	parent.velocity = SPEED * Vector2(randi_range(-1, 1), randi_range(-1, 1));
	get_node("MovementTimer").start();

func Exit() -> void:
	get_node("MovementTimer").stop();

func Physics_Update(delta: float) -> void:
	var collision : KinematicCollision2D = parent.move_and_collide(delta * parent.velocity);
	if (collision):
		parent.velocity = parent.velocity.bounce(collision.get_normal())

func _on_movement_timer_timeout() -> void:
	var new_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1));
	parent.velocity = SPEED * new_direction;
	if (new_direction == Vector2.ZERO):
		get_node("MovementTimer").start(1);
	else:
		get_node("MovementTimer").start(4);

