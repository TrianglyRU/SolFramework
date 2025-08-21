/// @self
/// @feather ignore GM1041
/// @feather ignore GM2018
/// @description Finds a tile along a vertical axis at the given position within a specified tile layer and returns an array containing two values: the distance to the tile's edge and its angle.
/// @param {Real} _x The x-coordinate of the position.
/// @param {Real} _y The y-coordinate of the position.
/// @param {Enum.DIRECTION} _dir The direction in which to perform the search.
/// @param {Enum.TILELAYER|Undefined} [_secondary_layer] The index of the secondary tile layer to search within (default is undefined).
/// @param {Enum.QUADRANT} [_quadrant] The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function tile_find_v(_x, _y, _dir, _secondary_layer = undefined, _quadrant = QUADRANT.DOWN)
{
    _x = floor(_x);
    _y = floor(_y);
	
    var _best_distance = TILE_SIZE * 2;
    var _best_ang = TILE_EMPTY_ANGLE;
	
    if (_x < 0 || _x > room_width)
    {
        return [_best_distance, _best_ang];
    }
    
    if (global.debug_collision == 1)
    {
        ds_list_add(obj_game.debug_tile_sensors, _x, _y, _x, y, _dir == DIRECTION.POSITIVE ? $47EC6D : $E9AB4D);
    }
    
	var _markers = obj_game.tile_markers;
	var _layers = obj_game.tile_layers;
	var _heights = obj_game.tile_heights;
	var _angles = obj_game.tile_angles;
	
	var _start_cell_id_x = floor(_x / TILE_SIZE);
    var _start_cell_id_y = floor(_y / TILE_SIZE);
	var _mod_x = _x % TILE_SIZE;
	
    for (var _j = array_length(_layers) - 1; _j >= 0; _j--)
	{
		if (_j != TILELAYER.MAIN && _j != _secondary_layer)
		{
			continue;
		}
		
        var _tile_layer = _layers[_j];
        if (_tile_layer == -1)
        {
            continue;
        }
        
        var _found = true;  
        var _result_ang = TILE_EMPTY_ANGLE;
		var _result_distance = _best_distance;
        var _cell_id_x = _start_cell_id_x;
        var _cell_id_y = _start_cell_id_y;
        var _tile, _index, _height, _mirror;
		
        for (var _i = 0; _i <= 2; _i++)
        {
			var _is_valid, _tile_buffer, _index_buffer, _height_buffer, _mirror_buffer;
			
			_tile = tilemap_get(_tile_layer, _cell_id_x, _cell_id_y);
			_mirror = tile_get_mirror(_tile);
			_index = tile_get_index(_tile);
			
			// Get height
			if (_tile == -1 || _index == 0)
			{
				_height = 0;
				_is_valid = false;
			}
			else
			{
				var _height_index;
				if (_mirror)
				{
					_height_index = TILE_SIZE - 1 - _mod_x;
				}
				else
				{
					_height_index = _mod_x;
				}
				
				_height = _heights[_index][_height_index];
				
				// Check validity
				var _marker_index = 0;
				var _marker_layer = _markers[_j];
				
				if (_marker_layer != -1)
				{
					var _marker_tile = tilemap_get(_markers[_j], _cell_id_x, _cell_id_y);
					if (_marker_tile != -1)
					{
						_marker_index = tile_get_index(_marker_tile);
					}
				}
				
				var _is_down = _quadrant == QUADRANT.DOWN;
				var _is_up = _quadrant == QUADRANT.UP;
				var _is_positive = _dir == DIRECTION.POSITIVE;
				
	            switch (_marker_index)
	            {
	                // Top Solid
	                case 1: 
	                    _is_valid = _is_down && _is_positive ||  _is_up && !_is_positive;
	                break;
					
	                // LBR Solid
	                case 2: 
	                    _is_valid = _is_down && !_is_positive || _is_up && _is_positive || !_is_down && !_is_up;
					break;
					
					// All Solid
					default:
						_is_valid = true;
	            }
			}
            
            // Initial tile check
            if (_i == 0)
            {
                if (!_is_valid)
                {
                    _cell_id_y += _dir;
                }
                else if (_height == TILE_SIZE)
                {
                    _tile_buffer = _tile;
                    _index_buffer = _index;
                    _height_buffer = _height;
					_mirror_buffer = _mirror;
                    _cell_id_y -= _dir;
					
					// Check closer tile (i = 2)
                    _i++;
                }
                else
                {
                    break;
                }
            }
            
            // Further tile check
            else if (_i == 1)
            {
                if (!_is_valid)
                {
                    _found = false;
                }
				
                break;
            }
            
            // Closer tile check
            else if (!_is_valid)
            {
                _tile = _tile_buffer;
                _index = _index_buffer;
                _height = _height_buffer;
				_mirror = _mirror_buffer;
                _cell_id_y += _dir;
            }
        }
        
        if (_found)
        {
            var _flip = tile_get_flip(_tile);

			// Get angle
			var _ang = _index <= 0 ? TILE_EMPTY_ANGLE : _angles[_index];
            if (_ang != TILE_EMPTY_ANGLE)
            {
                if (_ang > 0)
                {
                    if (_flip)
                    {
                        _ang = (540 - _ang) % 360;
                    }
                    
                    if (_mirror)
                    {
                        _ang = 360 - _ang;
                    }
                }
                else
                {
                    // Force full height if found from the opposite side
                    if (_height > 0)
                    {
                        if (_dir == DIRECTION.POSITIVE && _flip || _dir == DIRECTION.NEGATIVE && !_flip)
                        {
                            _height = TILE_SIZE;
                        }
                    }
                    
                    _ang = _dir == DIRECTION.POSITIVE ? 0 : 180;
                }
            }

            if (_dir == DIRECTION.POSITIVE)
            {
                _result_distance = _cell_id_y * TILE_SIZE + TILE_SIZE - 1 - _height - _y;
            }
            else
            {
                _result_distance = _y - _cell_id_y * TILE_SIZE - _height;
            }
			
            _result_ang = _ang;
        }
        
		// Get closest tile among the checked layers
        if (_result_distance < _best_distance)
        {
            _best_distance = _result_distance;
            _best_ang = _result_ang;
        }
    }
    
    return [_best_distance, _best_ang];
}