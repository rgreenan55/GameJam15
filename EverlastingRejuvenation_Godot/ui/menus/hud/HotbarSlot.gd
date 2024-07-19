extends Button

@export var key_toggle : StringName;
var is_active : bool = false;

func _process(_delta: float) -> void:
	if (key_toggle && Input.is_action_just_pressed(key_toggle)):
		is_active = !is_active;

	if(is_active):
		get_node("Background").modulate = Color.WHITE;
	else:
		get_node("Background").modulate = Color.WEB_GRAY;

func _on_pressed() -> void:
	is_active = !is_active;
