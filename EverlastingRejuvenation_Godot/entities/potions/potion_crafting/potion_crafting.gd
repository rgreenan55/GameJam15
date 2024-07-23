class_name potion_crafting extends Node;

signal toggle_menu(is_open : bool);
var is_menu_open : bool = false;

@export var potion_queue : Array[Potion] = [];

var graph : Dictionary = {
	1: {
		2: "res://entities/potions/potion_types/WaterPotion.tscn",
		3: "res://entities/potions/potion_types/PolymorphPotion.tscn",
		4: "res://entities/potions/potion_types/ShadowPotion.tscn",
	},
	2: {
		3: "res://entities/potions/potion_types/WaterPotion.tscn",
		4: "res://entities/potions/potion_types/WaterPotion.tscn",
	},
	3: {
		4: "res://entities/potions/potion_types/WaterPotion.tscn",
	},
}

func _process(delta: float) -> void:
	pass; #print(potion_queue);

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("OpenCraftingMenu")):
		is_menu_open = !is_menu_open;
		emit_signal("toggle_menu", is_menu_open);

func force_close_menu() -> void:
	if (is_menu_open):
		is_menu_open = false;
		emit_signal("toggle_menu", false);

func craft_potion(ingredient1 : int, ingredient2 : int) -> void:
	if (potion_queue.size() < 3):
		var potion : Potion = load("res://entities/potions/Potion.tscn").instantiate();
		potion.type_scene = load(graph[ingredient1][ingredient2]);
		potion_queue.push_back(potion);
	else:
		push_warning("PotionCrafting: Too many potions in queue");

func throw_potion() -> Potion:
	if (potion_queue.size() > 0):
		return potion_queue.pop_front();
	else:
		push_warning("PotionCrafting: No potions crafted");
		return null;
