/// @self
/// @feather ignore GM1041
/// @feather ignore GM2018
/// @description Finds a tile along a horizontal axis at the given position within a specified tile layer and returns an array containing two values: the distance to the tile's edge and its angle.
/// @param {Real} _x The x-coordinate of the position.
/// @param {Real} _y The y-coordinate of the position.
/// @param {Real} _dir The direction in which to perform the search.
/// @param {Enum.TILE_LAYER|Undefined} [_secondary_layer] The index of the secondary tile layer to search within (default is undefined).
/// @param {Enum.QUADRANT} [_quadrant] The angle range the check is happening within. This will affect if tile properties are gonna be rotated (default is QUADRANT.DOWN).
/// @returns {Array<Real>}
function collision_tile_h(_x, _y, _dir, _secondary_layer = undefined, _quadrant = QUADRANT.DOWN)
{
	_x = floor(_x);
	_y = floor(_y);
	_y = max(0, _y);
	
	var _best_distance = TILE_SIZE * 2;
    var _best_ang = TILE_EMPTY_ANGLE;
	
	if _y > room_height
	{
		return [_best_distance, _best_ang];
	}
	
	var _markers = obj_game.tile_markers;
	var _layers = obj_game.tile_layers;
	var _widths = obj_game.tile_widths;
	var _angles = obj_game.tile_angles;
	
	var _start_cell_id_x = floor(_x / TILE_SIZE);
    var _start_cell_id_y = floor(_y / TILE_SIZE);
	var _mod_y = _y % TILE_SIZE;
	
    for (var _j = array_length(_layers) - 1; _j >= 0; _j--)
	{
		if _j != TILE_LAYER.MAIN && _j != _secondary_layer
		{
			continue;
		}
		
        var _tile_layer = _layers[_j];
		
        if _tile_layer == -1
        {
            continue;
        }
        
        var _found = true;
        var _result_ang = TILE_EMPTY_ANGLE;
		var _result_distance = _best_distance;
        var _cell_id_x = _start_cell_id_x;
        var _cell_id_y = _start_cell_id_y;
        var _tile, _index, _w, _flip;
		
        for (var _i = 0; _i <= 2; _i++)
        {
			var _is_valid, _tile_buffer, _index_buffer, _width_buffer, _flip_buffer;
			
			_tile = tilemap_get(_tile_layer, _cell_id_x, _cell_id_y);
			_flip = tile_get_flip(_tile);
			_index = tile_get_index(_tile);	
			
			// Get width
			if _tile == -1 || _index == 0
			{
				_w = 0;
				_is_valid = false;
			}
			else
			{
				var _width_index;
				
				if _flip
				{
					_width_index = TILE_SIZE - 1 - _mod_y;
				}
				else
				{
					_width_index = _mod_y;
				}
				
				_w = _widths[_index][_width_index];
			
				// Check validity
				var _marker_index = 0;
				var _marker_layer = _markers[_j];
				
				if _marker_layer != -1
				{
					var _marker_tile = tilemap_get(_markers[_j], _cell_id_x, _cell_id_y);
					
					if _marker_tile != -1
					{
						_marker_index = tile_get_index(_marker_tile);
					}
				}
				
				var _is_right = _quadrant == QUADRANT.RIGHT;
				var _is_left = _quadrant == QUADRANT.LEFT;
				var _is_positive = _dir == 1;
			
				switch _marker_index
				{	
					// Top Solid
					case 1:
						_is_valid = _is_right && _is_positive || _is_left && !_is_positive;
					break;
					
					// LBR Solid
					case 2:
						_is_valid = _is_right && !_is_positive || _is_left && _is_positive || !_is_right && !_is_left;
					break;
					
					// All Solid
					default:
						_is_valid = true;
				}
			}
			
			// Initial tile check
			if _i == 0
			{
				if _w == 0 || !_is_valid
				{
					_cell_id_x += _dir;
				}
				else if _w == TILE_SIZE
				{
					_tile_buffer = _tile;
					_index_buffer = _index;
					_width_buffer = _w;
					_flip_buffer = _flip;
					_cell_id_x -= _dir;
					
					// Check closer tile (i = 2)
                    _i++;
				}
				else
				{
					break;
				}
			}
		
			// Further tile check
			else if _i == 1
			{
				if !_is_valid
				{
					_found = false;
				}
			
				break;
			}
			
			// Closer tile check
			else if !_is_valid
			{
				_tile = _tile_buffer;
				_index = _index_buffer;
				_w = _width_buffer;
				_flip = _flip_buffer;
				_cell_id_x += _dir;
			
				break;
			}
        }
        
        if _found
        {
			var _mirror = tile_get_mirror(_tile);
			var _ang = _index <= 0 ? TILE_EMPTY_ANGLE : _angles[_index];
			
			// Get angle
			if _ang != TILE_EMPTY_ANGLE
			{
				if _ang > 0
				{
					if _flip
					{
						_ang = (540 - _ang) % 360;
					}
			
					if _mirror
					{
						_ang = 360 - _ang;
					}
				}
				else
				{
					_ang = _dir == 1 ? 90 : 270;
				}
			}
			
			if _dir == 1
			{
				_result_distance = _cell_id_x * TILE_SIZE + TILE_SIZE - 1 - _w - _x;
			}
			else
			{
				_result_distance = _x - _cell_id_x * TILE_SIZE - _w;
			}
			
            _result_ang = _ang;
        }
        
		// Get closest tile among the checked layers
        if _result_distance < _best_distance
        {
            _best_distance = _result_distance;
            _best_ang = _result_ang;
        }
    }
	
	return [_best_distance, _best_ang];
}