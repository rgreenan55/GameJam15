class_name DLCText extends Label;

var text_options : Array[String] = [
	"I literally do nothing.",
	"-$500",
	"Yawn...",
	"4 8 15 16 23 42",
	"*cricket sound*",
];

func _ready() -> void:
	text = text_options.pick_random();
	label_settings = LabelSettings.new();
	label_settings.font_color = "#FFF";
	label_settings.font_size = 4;
	label_settings.outline_color = "#000";
	label_settings.outline_size = 1;
	z_index = 5;

	await resized;
	pivot_offset = randf_range(-1, 1) * Vector2(size / 2);

	var tween = get_tree().create_tween();
	tween.set_parallel(true);
	tween.tween_property(self, "position:y", position.y - 32, 1.5).set_ease(Tween.EASE_OUT);
	tween.tween_property(self, "modulate:a", 0, 1).set_ease(Tween.EASE_IN).set_delay(0.5);
	await tween.finished;
	queue_free();
