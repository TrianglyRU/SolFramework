/// @self
/// @description Finds a tile along a horizontal axis at the given position within a specified tile layer and returns an array containing two values: the distance to the tile's edge and its angle.
/// @param {Real} _x The x-coordinate of the position.
/// @param {Real} _y The y-coordinate of the position.
/// @param {Enum.DIRECTION|Real} _dir The direction in which to perform the search.
/// @param {Enum.TILELAYER|Real} _layer The index of the tile layer to search within.
/// @param {Enum.TILEBEHAVIOUR|Real} [_behaviour] The behaviour type of the tile (default is TILEBEHAVIOUR.DEFAULT).
/// @returns {Array<Real>}
function tile_find_h(_x, _y, _dir, _layer, _behaviour = TILEBEHAVIOUR.DEFAULT)
{	
	var _tile_layer = obj_framework.tile_layers[_layer];
	
	if (_layer == TILELAYER.NONE || _tile_layer == undefined)
	{
		return [TILE_SIZE * 2, TILE_EMPTY_ANGLE];
	}
	
	_x = floor(_x);
	_y = floor(_y);
	_y = max(0, _y);
	
	if (_y > room_height)
	{
		return [TILE_SIZE * 2, TILE_EMPTY_ANGLE];
	}
	
	if (global.debug_collision == 1)
	{
		ds_list_add(obj_framework.debug_tile_sensors, _x, _y, x, _y, _dir == DIRECTION.POSITIVE ? $5961E9 : $F84AEA);
	}
	
	var _tiledata, _index, _width, _is_valid, _tile_buffer, _index_buffer, _width_buffer;
	
	var _cell_id_x = floor(_x / TILE_SIZE);
	var _cell_id_y = floor(_y / TILE_SIZE);
	
	for (var _i = 0; _i <= 2; _i++)
	{
		_tiledata = tilemap_get(_tile_layer, _cell_id_x, _cell_id_y);
		_index = tile_get_index(_tiledata);
		_width = tile_get_width(_tiledata, _y);
		_is_valid = tile_get_validity_h(_tiledata, _dir, _behaviour);
		
		// Initial tile check
		if (_i == 0)
		{
			if (_width == 0 || !_is_valid)
			{
				_cell_id_x += _dir;
			}
			else if (_width == TILE_SIZE)
			{
				_tile_buffer = _tiledata;
				_index_buffer = _index;
				_width_buffer = _width;
				_cell_id_x -= _dir;
				
				// This will set _i to 2
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
				return [TILE_SIZE * 2, TILE_EMPTY_ANGLE];
			}
			
			break;
		}
		
		// Closer tile check
		else if (_i == 2 && (_width == 0 || !_is_valid))
		{
			_tiledata = _tile_buffer;
			_index = _index_buffer;
			_width = _width_buffer;
			_cell_id_x += _dir;
			
			break;
		}
	}
	
	var _flip = tile_get_flip(_tiledata);
	var _mirror = tile_get_mirror(_tiledata);
	var _ang = tile_get_angle(_tiledata);
	
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
			
			if (_ang >= 180 && _dir == DIRECTION.POSITIVE || _ang < 180 && _dir == DIRECTION.NEGATIVE)
			{
				_width = TILE_SIZE;
			}
		}
		else
		{
			_ang = _dir == DIRECTION.POSITIVE ? 90 : 270;
		}
	}
	
	var _distance;
	
	if (_dir == DIRECTION.POSITIVE)
	{
		_distance = _cell_id_x * TILE_SIZE + TILE_SIZE - 1 - _width - _x;
	}
	else
	{
		_distance = _x - _cell_id_x * TILE_SIZE - _width;
	}
	
	return [_distance, _ang];
}