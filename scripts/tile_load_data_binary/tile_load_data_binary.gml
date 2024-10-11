/// @self
/// @description Loads collision data from binary files located in /datafiles/collision. This function does not associate the data with any specific tilemap, so ensure you are loading data for the tilemap you are using.
/// @param {String} _width_data The filename (without extension) containing width data.
/// @param {String} _height_data The filename (without extension) containing height data.
/// @param {String} _angle_data The filename (without extension) containing angle data.
/// @param {String} _layer_a The name of the primary layer in the room.
/// @param {String} _layer_b The name of the secondary layer in the room.
function tile_load_data_binary(_width_data, _height_data, _angle_data, _layer_a, _layer_b)
{
	var _fw = obj_framework;
	var _data;
	
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
						_fw.tile_widths[_i][_j] = _i * TILE_SIZE < _size ? file_bin_read_byte(_file) : 0;
					}
					
				break;
				
				case 1:
				
					for (var _j = 0; _j < TILE_SIZE; _j++) 
					{
						_fw.tile_heights[_i][_j] = _i * TILE_SIZE < _size ? file_bin_read_byte(_file) : 0;
					}
					
				break;
			
				case 2:
				
					_fw.tile_angles[_i] = _i < _size ? math_get_angle_degree(file_bin_read_byte(_file)) : 0;
					
				break;
			}
		}
		
		file_bin_close(_file);									 
	}
	
	_fw.tile_layers = [layer_tilemap_get_id(_layer_a), layer_tilemap_get_id(_layer_b)];
}