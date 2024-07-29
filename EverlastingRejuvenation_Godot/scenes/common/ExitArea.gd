extends Area2D

signal exit_level;

func enable() -> void:
	get_node("Sprite").visible = true;
	get_node("CollisionShape2D").set_deferred("disabled", false);

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		emit_signal("exit_level");
