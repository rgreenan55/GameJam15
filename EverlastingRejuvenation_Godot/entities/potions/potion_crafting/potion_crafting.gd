class_name potion_crafting extends Node;

var graph : Dictionary = {
	1: {
		2: "res://entities/potions/potion_effects/WaterPotion.tscn",
		3: "res://entities/potions/potion_types/PolymorphPotion.tscn",
		4: "res://entities/potions/potion_types/ShadowPotion.tscn",
	},
	2: {
		3: "res://entities/potions/potion_effects/WaterPotion.tscn",
		4: "res://entities/potions/potion_effects/WaterPotion.tscn",
	},
	3: {
		4: "res://entities/potions/potion_effects/WaterPotion.tscn",
	},
}

func get_potion(ingredient1 : int, ingredient2 : int) -> String:
	return graph[ingredient1][ingredient2];
