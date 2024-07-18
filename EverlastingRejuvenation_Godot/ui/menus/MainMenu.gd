extends Control

@export var scene_manager : PackedScene;

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(scene_manager)

func _on_quit_game_pressed() -> void:
	get_tree().quit();
