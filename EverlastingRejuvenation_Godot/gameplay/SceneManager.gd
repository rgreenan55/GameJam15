class_name SceneManager extends Node2D

@onready var gameplay : Node2D = get_node("Gameplay");
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
	gameplay.get_node("Wizard").position = level_node.spawn_position;
	gameplay.get_node("UserInterface").visible = level_node.hud_active;
	clean_gameplay();

	add_child(level_node);
	move_child(level_node, 0);

func clean_gameplay():
	for potion in gameplay.get_node("PotionHandler/Potions").get_children():
		potion.queue_free();
