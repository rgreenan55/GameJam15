class_name IcePotion extends PotionType;

func apply_effect(node : CollisionObject2D) -> void:
	node.freeze();

func perform_on_landing(parent : Node2D) -> void:
	# This is terrible programming but whatever - future me problem if I ever work on this again.
	var tilemap : TileMap = parent.get_node("../../../LevelDesign/TileMap");
	var map_position = tilemap.local_to_map(parent.position)
	var tiles_to_convert : Array[Vector2i] = [ map_position ];

	var second_ring : Array[Vector2i] = tilemap.get_surrounding_cells(map_position);
	tiles_to_convert.append_array(second_ring);

	for tile : Vector2i in second_ring:
		var third_ring : Array[Vector2i] = tilemap.get_surrounding_cells(tile)
		tiles_to_convert.append_array(third_ring);

	while(tiles_to_convert.size() > 0):
		var current_position = tiles_to_convert.pop_front();
		var tile_data : TileData = tilemap.get_cell_tile_data(0, current_position, false); # 0 for ground
		if (tile_data && tile_data.terrain == 4):
			var atlas_coords : Vector2i = tilemap.get_cell_atlas_coords(0, current_position, false); # 0 for ground
			var souce_id : int = tilemap.get_cell_source_id(0, current_position, false);
			atlas_coords.x += 6;
			tilemap.set_cell(0, current_position, souce_id, atlas_coords);
