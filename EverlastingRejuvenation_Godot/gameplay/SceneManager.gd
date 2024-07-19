class_name SceneManager extends Node

@onready var level_id : int = 0;
var current_level : PackedScene;

func _ready() -> void:
	load_scene();

# Remove This
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("NextLevel")):
		next_scene();

func next_scene():
	remove_child(get_node("Level" + str(level_id)));
	level_id += 1;
	load_scene();

func load_scene():
	current_level = load("res://scenes/levels/Level" + str(level_id) + ".tscn");
	var level_node : Level = current_level.instantiate();

	# Handle Level Instructions
	get_node("HUD").visible = level_node.hud_active;
	add_child(level_node);
