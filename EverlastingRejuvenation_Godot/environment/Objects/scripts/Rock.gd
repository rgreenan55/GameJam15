extends StaticBody2D

func _ready() -> void:
	get_node("Sprite").frame = randi_range(0, 5);
