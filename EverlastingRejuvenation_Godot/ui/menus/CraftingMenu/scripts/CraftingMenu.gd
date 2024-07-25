extends CanvasLayer

var ingredient_count : int = 0;

func _on_mix_button_pressed() -> void:
	var slots : Array[Node] = get_node("IngredientSlots").get_children();
	var ingredients : Array[int] = [];

	# Verify Ingredient
	for slot : IngredientSlot in slots:
		if (slot.current_ingredient):
			ingredients.push_back(int(slot.current_ingredient.name.right(1)));
		else:
			return push_warning("Missing Ingredient")

	# Add Potion to Queue.
	ingredients.sort();
	PotionCrafting.craft_potion(ingredients[0], ingredients[1]);

func _ingredient_added() -> void:
	ingredient_count += 1;
	if (ingredient_count == 2):
		get_node("MixButton").disabled = false;

func _ingredient_removed() -> void:
	ingredient_count -= 1;
	get_node("MixButton").disabled = true;

func close_menu():
	for ingredient in get_node("Ingredients").get_children():
		ingredient.handle_close();
	for ingredient_slot in get_node("IngredientSlots").get_children():
		ingredient_slot.current_ingredient = null;
	ingredient_count = 0;
	get_node("MixButton").disabled = true;
