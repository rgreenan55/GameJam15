class_name PotionHandler extends Node2D

@export var potion_scene : PackedScene;
@onready var player = get_parent();

# Keep Track of Positions
func _process(_delta: float) -> void:
	get_node("ThrowLine").points = get_bezier_curve(position, get_local_mouse_position());

# On Mouse Click, Instantiate Potion Throw
func _on_potion_throw_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event.is_action("ThrowPotion") && Input.is_action_just_pressed("ThrowPotion")):
		player.emit_signal("throw_potion", player.position, get_global_mouse_position());

func _on_potion_throw_area_mouse_entered() -> void:
	get_node("ThrowLine").visible = true;

func _on_potion_throw_area_mouse_exited() -> void:
	get_node("ThrowLine").visible = false;

func get_bezier_curve(start : Vector2, end : Vector2) -> Array[Vector2]:
	var points : Array[Vector2] = [];
	var progress : float = 0.05;
	var mid = start.lerp(end, 0.5);
	mid.y -= 100;

	while (progress <= 1.05):
		var lerp0 = start.lerp(mid, progress);
		var lerp1 = mid.lerp(end, progress);
		var point = lerp0.lerp(lerp1, progress);
		points.push_back(point);
		progress += 0.05;
	return points;
