extends Scene

signal exit_level;
signal game_over;

@onready var label : Label = get_node("CanvasLayer/Label");
var current_line : int = 0;
var text_lines : Array = [
	"With the energy provided within the Shadow Gems...",
	"The Wizard was able to return his body to the World.",
	"And through his adventures, and idea sparked...",
];

func _ready() -> void:
	next_line();

func next_line() -> void:
	var tween : Tween = get_tree().create_tween();
	if (current_line < text_lines.size()):
		label.text = "";
		label.text = text_lines[current_line];
		label.visible_ratio = 0;
		tween.tween_property(label, "visible_ratio", 1, 2.5);
		get_node("CanvasLayer/NextLineTimer").start();
	else:
		await tween.tween_property(label, "modulate:a", 0, 1).finished;
		await get_tree().create_timer(1.0).timeout
		goto_next_scene();
	current_line += 1;

func goto_next_scene() -> void:
	var tween : Tween = get_tree().create_tween();
	await tween.tween_property(get_node("CanvasLayer/Coffee"), "modulate:a", 1, 2).finished;
	var tween2 : Tween = get_tree().create_tween();
	tween2.tween_property(get_node("CanvasLayer/CoffeeText"), "visible_ratio", 1, 1);
	await get_tree().create_timer(7.0).timeout
	emit_signal("exit_level");
