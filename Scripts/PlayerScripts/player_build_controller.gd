extends Node2D

@export var interactive_tilemap: TileMapLayer
@export var main_tilemap:TileMapLayer

#coordinates in our tileset of the appropriately setup brick type
var tileset_coords:Vector2 = Vector2(15,17)

#A dictionary of active player built tiles present in the scene keys as vector2 coords, value is decay time
var tiles_active = {}


func _physics_process(_delta: float) -> void:
	
	#Handle decaying tiles
	for tile_coord in tiles_active:
		var tile_data = interactive_tilemap.get_cell_tile_data(Vector2(tile_coord.x, tile_coord.y))

		if tile_data:
			var decaying = tile_data.get_custom_data("decaying")
			if decaying:
				tiles_active[tile_coord] -= _delta
				#print("Block at ", tile_coord, "has time left of ", tiles_active[tile_coord])
				if tiles_active[tile_coord] <= 0.0:
					interactive_tilemap.set_cell(Vector2(tile_coord.x, tile_coord.y), -1)
					tiles_active.erase(tile_coord)
		

#On right click draw the tile onto the map, add it to the active tiles if valid
func draw_tile(mouse_pos:Vector2) -> bool:
	
	var local_mouse_pos = interactive_tilemap.to_local(mouse_pos)
	var tile_coords = interactive_tilemap.local_to_map(local_mouse_pos)
	#print("Clicked the tile at:", tile_coords)

	#rule: tile may only be placed if at least one edge is adjacent to a permanent collidable tile
	#or next to a temporary tile already placed, allowing temporary extensions
	#take info from all 4 edges, refer back to the main level tilemap, check for tiles
	#rule: tile may not be placed in a spot already occupied by a permanent tile.
	#there is probably a more elegant way to do this instead of brute force checks

	var tile_above = Vector2(tile_coords.x, (tile_coords.y + 1) )
	var tile_below = Vector2(tile_coords.x, (tile_coords.y - 1) )
	var tile_right = Vector2((tile_coords.x + 1), tile_coords.y )
	var tile_left = Vector2((tile_coords.x - 1), tile_coords.y )

	if (main_tilemap.get_cell_source_id(tile_coords) == -1 and 
		#and one tile neighbor is a permanent block
		((main_tilemap.get_cell_source_id(tile_above) != -1 or
		main_tilemap.get_cell_source_id(tile_below) != -1 or
		main_tilemap.get_cell_source_id(tile_right) != -1 or
		main_tilemap.get_cell_source_id(tile_left) != -1 )) or 
		# OR one neighbor on our interactive layer is a placed block
		(interactive_tilemap.get_cell_source_id(tile_above) != -1 or
		interactive_tilemap.get_cell_source_id(tile_below) != -1 or
		interactive_tilemap.get_cell_source_id(tile_right) != -1 or
		interactive_tilemap.get_cell_source_id(tile_left) != -1 )
		):
		interactive_tilemap.set_cell(tile_coords, 0, tileset_coords)
	
		#collect tiles in dictionary keys, add decay time as value
		tiles_active[tile_coords] = interactive_tilemap.get_cell_tile_data(tile_coords).get_custom_data("decay_time")
		return true
	
	else: return false
	
