class_name IngredientSlot extends Node2D

signal ingredient_added
signal ingredient_removed

@export var current_ingredient : Ingredient;

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("IngredientUI")):
		if (!current_ingredient):
			body.desired_position = position;
			current_ingredient = body;
			emit_signal("ingredient_added");

func _on_body_exited(body: Node2D) -> void:
	if (body == current_ingredient):
		reset_ingredient();

func reset_ingredient() -> void:
	emit_signal("ingredient_removed");
	current_ingredient.reset_desired_position();
	current_ingredient = null;
