extends StaticBody2D

func extinguish() -> void:
	get_node("FireNoise").stop();
	get_node("AnimatedSprite").play("extinguish");
