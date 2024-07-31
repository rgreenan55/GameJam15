class_name SceneManager extends Node

@onready var level_id : int = 1;
@export var current_scene : PackedScene;
var scene_node : Scene;

func _ready() -> void:
	PotionCrafting.connect("toggle_menu", toggle_crafting_menu);
	load_scene();

func next_scene():
	PotionCrafting.reset();
	if (scene_node.next_scene):
		current_scene = scene_node.next_scene;
	else:
		get_node("GameOverMenu")._on_exit_pressed();
	load_scene();

func load_scene() -> void:
	if (scene_node):
		call_deferred("remove_child", scene_node);
	CollectibleHandler.reset();
	scene_node = current_scene.instantiate();
	scene_node.connect("game_over", game_over);
	if (scene_node.has_node("ExitArea")):
		scene_node.get_node("ExitArea").connect("exit_level", next_scene);
	else:
		scene_node.connect("exit_level", next_scene);
	get_node("HUD").visible = scene_node.hud_active;
	call_deferred("add_child", scene_node);

func _on_game_over_menu_retry() -> void:
	load_scene();

func game_over() -> void:
	PotionCrafting.reset();
	get_node("CraftingMenu").visible = false;
	get_node("HUD").visible = false;
	get_node("GameOverMenu").visible = true;
	get_tree().paused = true;

func toggle_crafting_menu(is_open : bool) -> void:
	if (scene_node.crafting_active):
		get_node("CraftingMenu").visible = is_open;
		if (!is_open):
			get_node("CraftingMenu").close_menu();
			get_node("HUD").get_node("CraftingIcon").visible = true;
		else:
			get_node("HUD").get_node("CraftingIcon").visible = false;
