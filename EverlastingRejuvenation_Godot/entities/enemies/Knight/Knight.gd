extends CharacterBody2D

@export var patrol_path : Curve2D;

func _ready() -> void:
	pass; #get_node("Patrol_Path").Curve = patrol_path;

func polymorph() -> void:
	modulate = Color.GREEN;
