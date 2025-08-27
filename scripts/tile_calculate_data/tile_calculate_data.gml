/// @self
/// @description Pre-calculates collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} _sprite_id The sprite used in the tilemap.
/// @param {Array<Real>|Undefined} _raw_angle_data An array of values representing a raw angle for each tile. Leave undefined to let the framework calculate it automatically.
/// @param {Real} _row_length The amount of tiles in each row.
function tile_calculate_data(_sprite_id, _raw_angle_data, _row_length)
{
	var _width = sprite_get_width(_sprite_id);
	var _height = sprite_get_height(_sprite_id);
	var _surface = surface_create(_width, _height);
	
	var _tile_count = (_width / TILE_SIZE) * (_height / TILE_SIZE);
	var _height_arr = array_create(_tile_count, 0);
	var _width_arr = array_create(_tile_count, 0);
	var _angle_arr = array_create(_tile_count, 0);
	var _angle_data_length = array_length(_raw_angle_data);
	
	sprite_set_offset(_sprite_id, 0, 0);
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	draw_sprite(_sprite_id, 0, 0, 0);
	surface_reset_target();
	
	var _obj = instance_create(0, 0, g_tile);
	for (var _i = 0; _i < _tile_count; _i++)
	{
		_height_arr[_i] = array_create(TILE_SIZE, 0);
		_width_arr[_i] = array_create(TILE_SIZE, 0);
		_angle_arr[_i] = 0;
		
		if (_i == 0)
		{
			continue;
		}
		
		var _tile = sprite_create_from_surface
		(
			_surface,
			TILE_SIZE * (_i % _row_length), 
			TILE_SIZE * floor(_i / _row_length), 
			TILE_SIZE, 
			TILE_SIZE,
			false, 
			false, 
			0, 
			0
		);
		
		sprite_collision_mask(_tile, true, 1, 0, 0, 0, 0, 0, 0);
		
		var _data = _obj.calculate_data(_tile);
		
		_height_arr[_i] = _data[0];
		_width_arr[_i] = _data[1];
		
		if (_raw_angle_data != undefined)
		{
			var _angle_index = _i - 1;
			if (_angle_index < _angle_data_length)
			{
				_angle_arr[_i] = math_get_angle_degree(_raw_angle_data[_angle_index]);
			}
		}
		else
		{
			#region ANGLE CALCULATION
			
			var _limit = TILE_SIZE - 1;
			
			var _top_dist_y = 0;
			var _bottom_dist_y = 0;
			var _top_dist_x = 0;
			var _bottom_dist_x = 0;
			
			var _x1 = _obj.x;
			var _y1 = _obj.y;
			var _x2 = _obj.x + _limit;
			var _y2 = _obj.y;
			var _x3 = _obj.x;
			var _y3 = _obj.y + _limit;
			var _x4 = _obj.x + _limit;
			var _y4 = _obj.y + _limit;
			
			// Move top-left
			while (!collision_point(_x1, _y1, g_tile, true, false) && _y1 < _limit)
			{
				_y1++;
				_top_dist_y++;
			}
			
			// Move top-right
			while (!collision_point(_x2, _y2, g_tile, true, false) && _y2 < _limit)
			{
				_y2++;
				_top_dist_y++;
			}
			
			// Align with the tile
			if (_y1 < _y2)
			{
				while (collision_point(_x1 + 1, _y1, g_tile, true, false) && _x1 < _limit)
				{
					_x1++;
					_top_dist_x++;
				}
			
				while (!collision_point(_x2, _y2, g_tile, true, false) && _x2 > 0)
				{
					_x2--;
					_top_dist_x++;
				}
			}
			else if (_y1 > _y2)
			{
				while (!collision_point(_x1, _y1, g_tile, true, false) && _x1 < _limit)
				{
					_x1++;
					_top_dist_x++;
				}
				
				while (collision_point(_x2 - 1, _y2, g_tile, true, false) && _x2 > 0)
				{
					_x2--;
					_top_dist_x++;
				}
			}
				
			// Move bottom-left
			while (!collision_point(_x3, _y3, g_tile, true, false) && _y3 > 0)
			{
				_y3--;
				_bottom_dist_y++;
			}
			
			// Move bottom-right
			while (!collision_point(_x4, _y4, g_tile, true, false) && _y4 > 0)
			{
				_y4--;
				_bottom_dist_y++;
			}
			
			// Align with the tile
			if (_y3 < _y4)
			{
				while (!collision_point(_x3, _y3, g_tile, true, false) && _x3 < _limit)
				{
					_x3++;
					_bottom_dist_x++;
				}
			
				while (collision_point(_x4 - 1, _y4, g_tile, true, false) && _x4 > 0)
				{
					_x4--;
					_bottom_dist_x++;
				}
			}
			else if (_y3 > _y4)
			{
				while (collision_point(_x3 + 1, _y3, g_tile, true, false) && _x3 < _limit)
				{
					_x3++;
					_bottom_dist_x++;
				}
				
				while (!collision_point(_x4, _y4, g_tile, true, false) && _x4 > 0)
				{
					_x4--;
					_bottom_dist_x++;
				}
			}
			
			/// @feather ignore GM2018
			var _is_upside_down;
			if (_top_dist_y == _bottom_dist_y)
			{
				_is_upside_down = _top_dist_x > _bottom_dist_x;
			}
			else
			{
				_is_upside_down = _bottom_dist_y > _top_dist_y;
			}
			
			var _angle;
			if (_is_upside_down)
			{
				_angle = point_direction(_x4, _y4, _x3, _y3);
			}
			else
			{
				_angle = point_direction(_x1, _y1, _x2, _y2);
			}
			
			_angle_arr[_i] = math_get_angle_rounded(_angle);
			
			#endregion
		}
		
		sprite_delete(_tile);
	}
	
	surface_free(_surface);
	instance_destroy(_obj);
	
	global.tile_stored_height_data[? _sprite_id] = _height_arr;	
	global.tile_stored_width_data[? _sprite_id] = _width_arr;
	global.tile_stored_angle_data[? _sprite_id] = _angle_arr;
	
	show_debug_message("[INFO] Calculated collision data for " + sprite_get_name(_sprite_id)
					+ (_raw_angle_data != undefined ? " with predefined angle map" : ""));
}