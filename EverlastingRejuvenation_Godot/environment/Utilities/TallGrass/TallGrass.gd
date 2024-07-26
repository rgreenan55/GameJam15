extends Area2D


func _on_body_entered(body: Node2D) -> void:
	var amount = randf_range(-10,10);
	rotation = deg_to_rad(amount);

func _on_body_exited(body: Node2D) -> void:
	rotation = 0;
