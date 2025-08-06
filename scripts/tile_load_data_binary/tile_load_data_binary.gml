/// @self
/// @description Loads collision data from binary files located in /datafiles/collision. This function does not associate the data with any specific tilemap, so ensure you are loading data for the tilemap you are using.
/// @param {String} _width_data The filename (without extension) containing width data.
/// @param {String} _height_data The filename (without extension) containing height data.
/// @param {String} _angle_data The filename (without extension) containing angle data.
/// @param {String} _layer_main The name of the main collision layer (TILELAYER.MAIN) in the room.
/// @param {String|Undefined} _layer_secondary_a The name of the first additional collision layer (TILELAYER.SECONDARY_A) in the room.
/// @param {String|Undefined} _layer_secondary_b The name of the second additional collision layer (TILELAYER.SECONDARY_B) in the room.
function tile_load_data_binary(_width_data, _height_data, _angle_data, _layer_main, _layer_secondary_a, _layer_secondary_b)
{
	obj_game.tile_layers = 
	[
		layer_tilemap_get_id(_layer_main),			// TILELAYER.MAIN (0)
		layer_tilemap_get_id(_layer_secondary_a),	// TILELAYER.SECONDARY_A (1)	
		layer_tilemap_get_id(_layer_secondary_b)	// TILELAYER.SECONDARY_B (2)
	];
	
	var _data;
	var _widths = obj_game.tile_widths;
	var _heights = obj_game.tile_heights;
	var _angles = obj_game.tile_angles;
		
	for (var _k = 0; _k < 3; _k++)
	{
		switch _k
		{
			case 0:
				_data = _width_data;
			break;
		
			case 1:
				_data = _height_data;
			break;
		
			case 2:
				_data = _angle_data;
			break;
		}
		
		var _file_name = "collision/" + _data + ".bin";
		var _file = file_bin_open(_file_name, 0);	
		var _size = file_bin_size(_file);
		
		if (!_file)
		{
			continue;
		}
		
		for (var _i = 0; _i < TILE_COUNT; _i++) 
		{
			switch (_k)
			{
				case 0:
				
					for (var _j = 0; _j < TILE_SIZE; _j++) 
					{
						_widths[_i][_j] = _i * TILE_SIZE < _size ? file_bin_read_byte(_file) : 0;
					}
					
				break;
				
				case 1:
				
					for (var _j = 0; _j < TILE_SIZE; _j++) 
					{
						_heights[_i][_j] = _i * TILE_SIZE < _size ? file_bin_read_byte(_file) : 0;
					}
					
				break;
			
				case 2:
					_angles[_i] = _i < _size ? math_get_angle_degree(file_bin_read_byte(_file)) : 0;
				break;
			}
		}
		
		file_bin_close(_file);									 
	}
}