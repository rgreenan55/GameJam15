class_name PotionType extends Node;

@export var group_check : String;
@export var primary_color : Color;
@export var secondary_color : Color;

func apply_effect(_node : CollisionObject2D) -> void:
	pass;

func perform_on_landing(_parent : Node2D) -> void:
	pass;
