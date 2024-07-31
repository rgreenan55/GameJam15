class_name Level extends Scene

signal game_over;
signal collectible_count;
signal collectible;

@export var spawn_position : Vector2;
@onready var player_scene : PackedScene = load("res://entities/player/Wizard.tscn");
@onready var potion_scene : PackedScene = load("res://entities/potions/Potion.tscn");

var potion_types : Array[PackedScene] = [
	load("res://entities/potions/potion_types/WaterPotion.tscn"),
	load("res://entities/potions/potion_types/ShadowPotion.tscn"),
	load("res://entities/potions/potion_types/PolymorphPotion.tscn"),
];
var i : int = 0;

func _ready() -> void:
	CollectibleHandler.connect("current_changed", check_exit);
	initiate_player();
	initiate_collectibles();

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

func initiate_player() -> void:
	var player = player_scene.instantiate();
	player.position = spawn_position;
	player.connect("throw_potion", spawn_potion);
	player.connect("player_death", emit_game_over);
	get_node("Entities/Player").add_child(player);

func initiate_collectibles() -> void:
	CollectibleHandler.set_total(get_tree().get_nodes_in_group("Collectible").size());

func check_exit(val : int, total : int) -> void:
	if (total != 0 && val >= total): get_node("ExitArea").enable();
