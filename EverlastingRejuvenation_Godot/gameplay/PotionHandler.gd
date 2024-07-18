class_name PotionHandler extends Node2D

@export var potion_scene : PackedScene;
@onready var player = get_node("../Wizard");



# Position Tracking
var player_position : Vector2;
var mouse_position : Vector2;
var middle_position : Vector2;

# Keep Track of Positions
func _process(_delta: float) -> void:
	# Handle On/Off Until Mixing Setup
	if (Input.is_action_just_pressed("TogglePotion")):
		$"../Wizard/PotionThrowArea/PotionThrowRange".disabled = !$"../Wizard/PotionThrowArea/PotionThrowRange".disabled;
		get_node("ThrowLine").visible = false;

	# Get Positons for Bezier Curve
	player_position = player.position;
	mouse_position = get_global_mouse_position();
	middle_position = player_position.lerp(mouse_position, 0.5);
	middle_position.y -= 100;
	get_node("ThrowLine").points = get_bezier_curve();

# On Mouse Click, Instantiate Potion Throw
func _on_potion_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event.is_action("ThrowPotion") && Input.is_action_just_pressed("ThrowPotion")):
		var potion : Potion = potion_scene.instantiate();
		# Chance this to so potions don't collide with player
		potion.position = player.position;
		potion.position.y -= 16;
		potion.start_position = potion.position;
		potion.end_position = mouse_position;
		potion.mid_position = middle_position;
		get_node("Potions").add_child(potion);

func _on_potion_throw_area_mouse_entered() -> void:
	get_node("ThrowLine").visible = true;

func _on_potion_throw_area_mouse_exited() -> void:
	get_node("ThrowLine").visible = false;

func get_bezier_curve() -> Array[Vector2]:
	var points : Array[Vector2] = [];
	var progress : float = 0;
	while (progress <= 1.05):
		var lerp0 = player_position.lerp(middle_position, progress);
		var lerp1 = middle_position.lerp(mouse_position, progress);
		var point = lerp0.lerp(lerp1, progress);
		points.push_back(point);
		progress += 0.05;
	return points;
