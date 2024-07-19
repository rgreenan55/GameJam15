class_name Potion extends CharacterBody2D

@export var start_position : Vector2;
@export var end_position : Vector2;
@export var middle_position : Vector2;
@export var effect_scene : PackedScene;

var effect : PotionEffect;

func _ready() -> void:
	effect = effect_scene.instantiate();
