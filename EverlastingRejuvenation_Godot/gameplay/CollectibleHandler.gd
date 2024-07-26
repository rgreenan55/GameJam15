class_name collectible_handler extends Node

signal current_changed(val : int, total : int);

@export var total : int = 0;
@export var current : int = 0;

func set_total(val : int) -> void:
	total = val;
	emit_signal("current_changed", current, total);

func collected() -> void:
	current = min(total, current+1);
	emit_signal("current_changed", current, total);

func reset() -> void:
	total = 0;
	current = 0;
	emit_signal("current_changed", current, total);
