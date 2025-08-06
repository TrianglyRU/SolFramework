/// @self
/// @description Pre-calculates collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} _sprite_id The sprite used in the tilemap.
/// @param {Array<Real>|Undefined} _angle_data An array of values representing the angles for each tile. Leave undefined to let the framework calculate it automatically.
/// @param {Real} _off_x The horizontal offset of the sprite on the tilemap.
/// @param {Real} _off_y The vertical offset of the sprite on the tilemap.
/// @param {Real} _sep_x The horizontal spacing between tiles on the tilemap.
/// @param {Real} _sep_y The vertical spacing between tiles on the tilemap.
/// @param {Real} _row_length The amount of tiles in each row.
function tile_calculate_data(_sprite_id, _angle_data, _off_x, _off_y, _sep_x, _sep_y, _row_length)
{
	var _surface = surface_create(sprite_get_width(_sprite_id), sprite_get_height(_sprite_id));
	var _height_arr = array_create(TILE_COUNT, 0);
	var _width_arr = array_create(TILE_COUNT, 0);
	var _angle_arr = array_create(TILE_COUNT, 0);
	var _angle_data_length = array_length(_angle_data);
	var _xcell_size = TILE_SIZE + _sep_x;
	var _ycell_size = TILE_SIZE + _sep_y;
	
	sprite_set_offset(_sprite_id, 0, 0);
	surface_set_target(_surface);
	draw_clear_alpha(c_black, 0);
	draw_sprite(_sprite_id, 0, 0, 0);
	surface_reset_target();
	
	var _obj = instance_create(0, 0, obj_game_tile);
	for (var _i = 0; _i < TILE_COUNT; _i++)
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
			_off_x + _xcell_size * (_i % _row_length), 
			_off_y + _ycell_size * floor(_i / _row_length), 
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
		
		if (_angle_data != undefined)
		{
			var _angle_index = _i - 1;
			if (_angle_index < _angle_data_length)
			{
				_angle_arr[_i] = math_get_angle_degree(_angle_data[_angle_index]);
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
			while (!collision_point(_x1, _y1, obj_game_tile, true, false) && _y1 < _limit)
			{
				_y1++;
				_top_dist_y++;
			}
			
			// Move top-right
			while (!collision_point(_x2, _y2, obj_game_tile, true, false) && _y2 < _limit)
			{
				_y2++;
				_top_dist_y++;
			}
			
			// Align with the tile
			if (_y1 < _y2)
			{
				while (collision_point(_x1 + 1, _y1, obj_game_tile, true, false) && _x1 < _limit)
				{
					_x1++;
					_top_dist_x++;
				}
			
				while (!collision_point(_x2, _y2, obj_game_tile, true, false) && _x2 > 0)
				{
					_x2--;
					_top_dist_x++;
				}
			}
			else if (_y1 > _y2)
			{
				while (!collision_point(_x1, _y1, obj_game_tile, true, false) && _x1 < _limit)
				{
					_x1++;
					_top_dist_x++;
				}
				
				while (collision_point(_x2 - 1, _y2, obj_game_tile, true, false) && _x2 > 0)
				{
					_x2--;
					_top_dist_x++;
				}
			}
				
			// Move bottom-left
			while (!collision_point(_x3, _y3, obj_game_tile, true, false) && _y3 > 0)
			{
				_y3--;
				_bottom_dist_y++;
			}
			
			// Move bottom-right
			while (!collision_point(_x4, _y4, obj_game_tile, true, false) && _y4 > 0)
			{
				_y4--;
				_bottom_dist_y++;
			}
			
			// Align with the tile
			if (_y3 < _y4)
			{
				while (!collision_point(_x3, _y3, obj_game_tile, true, false) && _x3 < _limit)
				{
					_x3++;
					_bottom_dist_x++;
				}
			
				while (collision_point(_x4 - 1, _y4, obj_game_tile, true, false) && _x4 > 0)
				{
					_x4--;
					_bottom_dist_x++;
				}
			}
			else if (_y3 > _y4)
			{
				while (collision_point(_x3 + 1, _y3, obj_game_tile, true, false) && _x3 < _limit)
				{
					_x3++;
					_bottom_dist_x++;
				}
				
				while (!collision_point(_x4, _y4, obj_game_tile, true, false) && _x4 > 0)
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
	
	if (!global.tools_binary_collision)
	{
		global.tile_generated_height_data[? _sprite_id] = _height_arr;
		global.tile_generated_width_data[? _sprite_id] = _width_arr;
		global.tile_generated_angle_data[? _sprite_id] = _angle_arr;
	}
	else
	{
		var _prefix = sprite_get_name(_sprite_id);
		
		show_debug_message
		(
			"=============================================================================================================\n"
	      + "GENERATED COLLISION FOR " + _prefix + " WAS SAVED INTO THE BINARY FILES. IT IS NOT REGISTERED IN THE GAME!\n"
	      + "============================================================================================================="
		);
		
	    var _width_filename = _prefix + "_widths.bin";
	    var _height_filename = _prefix + "_heights.bin";
	    var _angle_filename = _prefix + "_angles.bin";
		
	    var _width_file = file_bin_open(_width_filename, 1);
	    for (var _i = 0; _i < TILE_COUNT; _i++)
	    {
	        for (var _j = 0; _j < TILE_SIZE; _j++)
	        {
	            file_bin_write_byte(_width_file, _width_arr[_i][_j]);
	        }
	    }
    
	    file_bin_close(_width_file);
		
	    var _height_file = file_bin_open(_height_filename, 1);
	    for (var _i = 0; _i < TILE_COUNT; _i++)
	    {
	        for (var _j = 0; _j < TILE_SIZE; _j++)
	        {
	            file_bin_write_byte(_height_file, _height_arr[_i][_j]);
	        }
	    }
		
	    file_bin_close(_height_file);
    
	    var _angle_file = file_bin_open(_angle_filename, 1);
		for (var _i = 0; _i < TILE_COUNT; _i++)
		{
		    file_bin_write_byte(_angle_file, math_get_angle_raw(_angle_arr[_i]));
		}
		
	    file_bin_close(_angle_file);
	}
}