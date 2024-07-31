class_name Collectible extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		CollectibleHandler.collected();
		get_node("CollisionShape").set_deferred("disabled", true);
		get_node("Sprite").visible = false;
		get_node("Particles").emitting = true;
		get_node("Sound").playing = true;
		await get_node("Particles").finished;
		queue_free();
