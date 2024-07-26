extends CharacterBody2D

@onready var state_machine : StateMachine = get_node("KnightStateMachine");

func _process(_delta: float) -> void:
	if (velocity == Vector2.ZERO): get_node("Visuals/Animations").play("idle");
	else: get_node("Visuals/Animations").play("walking");

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

func unpolymorph() -> void:
	get_node("Visuals/Sprite").visible = true;
	get_node("Visuals/PolymorphSprite").visible = false;
	get_node("LightSource").relight();

func freeze() -> void:
	state_machine.on_child_transitioned("FrozenKnightState");

func explode() -> void:
	if (state_machine.current_state.name == "FrozenKnightState"):
		state_machine.on_child_transitioned("IdleKnightState");
	# play grunt sound queue
