class_name Level extends Node2D

signal game_over;

@export var spawn_position : Vector2;
@export var hud_active : bool = true;

@onready var player_scene : PackedScene = load("res://entities/player/Wizard.tscn");
@onready var potion_scene : PackedScene = load("res://entities/potions/Potion.tscn");

var potion_types : Array[PackedScene] = [
	load("res://entities/potions/potion_types/WaterPotion.tscn"),
	load("res://entities/potions/potion_types/ShadowPotion.tscn"),
	load("res://entities/potions/potion_types/PolymorphPotion.tscn"),
];
var i : int = 0;

func _ready() -> void:
	var player = player_scene.instantiate();
	player.position = spawn_position;
	player.connect("throw_potion", spawn_potion);
	player.connect("player_death", emit_game_over);
	get_node("Entities/Player").add_child(player);

func spawn_potion(start : Vector2, end : Vector2):
	var potion : Potion = PotionCrafting.throw_potion();
	if (!potion): return;
	potion.start_position = start;
	potion.middle_position = start.lerp(end, 0.5);
	potion.middle_position.y -= 100;
	potion.end_position = end;
	get_node("Entities/Potions").add_child(potion);

func emit_game_over() -> void:
	emit_signal("game_over");
