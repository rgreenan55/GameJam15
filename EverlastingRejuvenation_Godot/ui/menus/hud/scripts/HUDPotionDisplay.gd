extends VBoxContainer

@onready var sprite_queue : Array[Resource] = [];

func _ready() -> void:
	PotionCrafting.connect("queue_changed", update_hotbar);
	PotionCrafting.connect("queue_reset", reset_hotbar);

func update_hotbar(type_name : String, is_thrown : bool) -> void:
	var hotbar_slots : Array[Node] = get_children();

	if (is_thrown):
		sprite_queue.pop_front();
	else:
		sprite_queue.push_back(load("res://entities/potions/potion_types/assets/" + type_name + ".png"));

	for i in hotbar_slots.size():
		if (i < sprite_queue.size() && sprite_queue[i]):
			hotbar_slots[i].get_node("PotionSprite").set_texture(sprite_queue[i]);
		else:
			hotbar_slots[i].get_node("PotionSprite").set_texture(null);

func reset_hotbar() -> void:
	sprite_queue = [];
	for hotbar_slot in get_children():
		hotbar_slot.get_node("PotionSprite").set_texture(null);

