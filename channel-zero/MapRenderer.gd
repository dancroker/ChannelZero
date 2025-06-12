extends Node2D

func draw_map_visual(map):
	var tilemap = get_parent() as TileMap
	#if tilemap == null:
	#	print("Error: Parent is not a TileMap!")
	#	return
	tilemap.clear()
	for y in range(map.size()):
		for x in range(map[0].size()):
			var tile = map[y][x]
			if tile == "#":
				tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0))  # Wall Tile
			elif tile == "x":
				tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(2, 0))  # Enemy Team Spawn Tile
			elif tile == "o":
				tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(3, 0))  # Player Team Spawn Tile
			elif tile == "@":
				tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(4, 0))  # Exit Map Tile
			else:
				tilemap.set_cell(0, Vector2i(x, y), 0, Vector2i(1, 0))  # Floor Tile
