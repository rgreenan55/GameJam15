class_name Level extends Node2D

@export var spawn_position : Vector2;
@export var hud_active : bool = true;

@onready var player_scene : PackedScene = load("res://entities/player/Wizard.tscn");
@onready var potion_scene : PackedScene = load("res://entities/potions/Potion.tscn")

func _ready() -> void:
	var player = player_scene.instantiate();
	player.position = spawn_position;
	player.connect("throw_potion", spawn_potion);
	get_node("Entities/Player").add_child(player);

func spawn_potion(start : Vector2, end : Vector2):
	var potion : Potion = potion_scene.instantiate();
	potion.start_position = start;
	potion.middle_position = start.lerp(end, 0.5);
	potion.middle_position.y -= 100;
	potion.end_position = end;
	add_child(potion);
