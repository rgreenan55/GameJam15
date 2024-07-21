class_name Potion extends CharacterBody2D

@export var start_position : Vector2;
@export var end_position : Vector2;
@export var middle_position : Vector2;
@export var type_scene : PackedScene;

var type : PotionType;

func _ready() -> void:
	type = type_scene.instantiate();
	get_node("Visuals/Sprite").modulate = type.primary_color;
