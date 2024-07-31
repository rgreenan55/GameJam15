class_name DLCPotion extends PotionType;

func perform_on_landing(parent : Node2D) -> void:
	var label : DLCText = DLCText.new();
	label.global_position = parent.position;
	parent.call_deferred("add_sibling", label);

