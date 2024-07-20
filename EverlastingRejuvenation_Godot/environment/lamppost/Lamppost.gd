extends StaticBody2D

func extinguish() -> void:
	get_node("AnimatedSprite").play("extinguish");
