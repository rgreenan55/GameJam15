extends CharacterBody2D

@onready var state_machine : StateMachine = get_node("KnightStateMachine");
var is_polymorphed : bool = false;

func _process(_delta: float) -> void:
	if (velocity == Vector2.ZERO or is_polymorphed):
		get_node("Visuals/Animations").play("idle");
		get_node("WalkingAudio").playing = false;
	else:
		get_node("Visuals/Animations").play("walking");
		if (get_node("WalkingAudio").playing == false):
			get_node("WalkingAudio").playing = true;

	if (velocity.x < 0):
		get_node("Visuals/Sprite").flip_h = true;
		get_node("Visuals/FreezeCoverSprite").flip_h = true;
	elif(velocity.x > 0):
		get_node("Visuals/Sprite").flip_h = false;
		get_node("Visuals/FreezeCoverSprite").flip_h = false;

func polymorph() -> void:
	get_node("Visuals/Sprite").visible = false;
	get_node("Visuals/PolymorphSprite").visible = true;
	get_node("LightSource").force_extinguish();
	state_machine.on_child_transitioned("IdleKnightState");
	get_node("PolymorphTimer").start();
	is_polymorphed = true;

func unpolymorph() -> void:
	get_node("Visuals/Sprite").visible = true;
	get_node("Visuals/PolymorphSprite").visible = false;
	get_node("LightSource").relight();
	is_polymorphed = false;

func freeze() -> void:
	state_machine.on_child_transitioned("FrozenKnightState");

func explode() -> void:
	if (state_machine.current_state.name == "FrozenKnightState"):
		state_machine.on_child_transitioned("IdleKnightState");
	# play grunt sound queue
