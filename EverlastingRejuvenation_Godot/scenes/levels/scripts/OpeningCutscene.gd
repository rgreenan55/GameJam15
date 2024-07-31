extends Scene

signal exit_level;
signal game_over;

@onready var label : Label = get_node("CanvasLayer/Label");
var current_line : int = 0;
var text_lines : Array = [
	"Once, there was a Wizard of great renown.",
	"His tower sat upon a hilltop overlooking the sea.",
	"This Wizard had one great desire.",
	"To craft the most incredible of potions.",
	"The Potion of Everlasting Rejuvenation.",
	"He worked tirelessly. Sunrise until Sunset.",
	"Until one fateful day...",
	"His experiment backfired.",
	"His body was lost, vanished into thin air.",
	"But... his Shadow remained.",
	"Avoid the Light.",
	"Collect the Shadow Gems.",
	"Reclaim your body..."
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
	emit_signal("exit_level");
