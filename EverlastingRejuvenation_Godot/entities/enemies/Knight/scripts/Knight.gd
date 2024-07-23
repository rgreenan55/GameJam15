extends CharacterBody2D

var temp_pos : Vector2;

func _ready() -> void:
	pass; #get_node("Patrol_Path").Curve = patrol_path;

func _process(_delta: float) -> void:
	if (temp_pos):
		if (temp_pos.x > global_position.x):
			get_node("Visuals/Sprite").flip_h = true;
		else:
			get_node("Visuals/Sprite").flip_h = false;
	temp_pos = global_position

func polymorph() -> void:
	modulate = Color.GREEN;
