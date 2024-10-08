class_name EntityPath extends Path2D

@export var speed_px : float = 30;
@export var path_entity_scene : PackedScene;

func _ready() -> void:
	if (path_entity_scene):
		var path_entity = path_entity_scene.instantiate();
		get_node("PathFollow2D").add_child(path_entity);

func _process(delta: float) -> void:
	get_node("PathFollow2D").progress += speed_px*delta
