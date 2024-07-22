extends CanvasLayer

signal retry
signal exit

# Requires Static Loading to prevent Circular Dependency Errors
var main_menu : PackedScene = load("res://ui/menus/MainManu/MainMenu.tscn")

func _on_retry_pressed() -> void:
	visible = false;
	get_tree().paused = false;
	retry.emit();

func _on_exit_pressed() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_packed(main_menu);
