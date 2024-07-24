class_name IngredientSlot extends Node2D

signal ingredient_added
signal ingredient_removed

@export var current_ingredient : Ingredient;
var temp_ingredient : Ingredient;

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("IngredientUI")):
		temp_ingredient = body;

func _on_body_exited(body: Node2D) -> void:
	if (body == current_ingredient):
		reset_ingredient();
	if (body == temp_ingredient):
		temp_ingredient = null;

func reset_ingredient() -> void:
	emit_signal("ingredient_removed");
	current_ingredient.reset_desired_position();
	current_ingredient = null;


func _on_ingredient_detector_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton && event.is_released()):
		if (temp_ingredient):
			if(current_ingredient): reset_ingredient();
			temp_ingredient.desired_position = position;
			current_ingredient = temp_ingredient;
			temp_ingredient = null;
			emit_signal("ingredient_added");
