class_name potion_crafting extends Node;

signal toggle_menu(is_open : bool);
signal queue_changed(type_name : String, is_thorwn : bool);
signal queue_reset();

@export var is_menu_open : bool = false;
@export var potion_queue : Array[Potion] = [];


var graph : Dictionary = {
	1: {
		2: "WaterPotion",
		3: "PolymorphPotion",
		4: "IcePotion",
	},
	2: {
		3: "ExplosivePotion",
		4: "ShadowPotion",
	},
	3: {
		4: "WaterPotion",
	},
}

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("OpenCraftingMenu")):
		is_menu_open = !is_menu_open;
		emit_signal("toggle_menu", is_menu_open);

func reset() -> void:
	is_menu_open = false;
	potion_queue = [];
	emit_signal("queue_reset");

func force_close_menu() -> void:
	if (is_menu_open):
		is_menu_open = false;
		emit_signal("toggle_menu", false);

func craft_potion(ingredient1 : int, ingredient2 : int) -> void:
	if (potion_queue.size() < 3):
		var potion : Potion = load("res://entities/potions/Potion.tscn").instantiate();
		var potion_type_name : String = graph[ingredient1][ingredient2];
		potion.type_scene = load("res://entities/potions/potion_types/" + potion_type_name + ".tscn");
		potion_queue.push_back(potion);
		emit_signal("queue_changed", potion_type_name, false);
	else:
		# Visual Indicator Here
		push_warning("PotionCrafting: Too many potions in queue");

func throw_potion() -> Potion:
	if (potion_queue.size() > 0):
		emit_signal("queue_changed", "", true);
		return potion_queue.pop_front();
	else:
		return null;
