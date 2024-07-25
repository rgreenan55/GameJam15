extends Control

func _ready() -> void:
	PotionCrafting.connect("queue_changed", check_throw);

func _process(_delta: float) -> void:
	get_node("ThrowVisual").value = 100 * (get_node("ThrowTimer").time_left / get_node("ThrowTimer").wait_time);

func check_throw(_type : String, is_throw : bool):
	if (is_throw):
		get_node("ThrowTimer").start();
