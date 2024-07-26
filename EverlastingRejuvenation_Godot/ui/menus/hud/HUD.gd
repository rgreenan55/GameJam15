extends CanvasLayer

func _ready() -> void:
	CollectibleHandler.connect("current_changed", update_collectible);

func update_collectible(current : int, total : int) -> void:
	get_node("InfoBox/CollectibleDisplay/Label").text = str(current) + " / " + str(total);
