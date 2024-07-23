class_name SceneManager extends Node

@onready var level_id : int = 0;
var current_level : PackedScene;

func _ready() -> void:
	PotionCrafting.connect("toggle_menu", toggle_crafting_menu);
	load_scene();

# Remove This
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("NextLevel")):
		next_scene();

func next_scene():
	PotionCrafting.reset();
	remove_child(get_node("Level" + str(level_id)));
	level_id += 1;
	load_scene();

func load_scene() -> void:
	current_level = load("res://scenes/levels/Level" + str(level_id) + ".tscn");
	var level_node : Level = current_level.instantiate();
	level_node.connect("game_over", game_over);

	# Handle Level Instructions
	get_node("HUD").visible = level_node.hud_active;
	add_child(level_node);

func _on_game_over_menu_retry() -> void:
	remove_child(get_node("Level" + str(level_id)));
	load_scene();

func game_over() -> void:
	PotionCrafting.reset();
	get_node("CraftingMenu").visible = false;
	get_node("HUD").visible = false;
	get_node("GameOverMenu").visible = true;
	get_tree().paused = true;

func toggle_crafting_menu(is_open : bool) -> void:
	get_node("CraftingMenu").visible = is_open;
	if (!is_open):
		get_node("CraftingMenu").close_menu();
		get_node("HUD").visible = true;
	else:
		get_node("HUD").visible = false;
