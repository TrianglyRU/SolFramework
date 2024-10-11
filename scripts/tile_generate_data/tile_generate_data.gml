/// @self
/// @description Generates collision data for the tilemap associated with the specified sprite.
/// @param {Asset.GMSprite} _sprite_id The sprite used in the tilemap.
/// @param {Array<Real>} _angle_data An array of values representing the angles for each tile.
/// @param {Real} _off_x The horizontal offset of the sprite on the tilemap.
/// @param {Real} _off_y The vertical offset of the sprite on the tilemap.
/// @param {Real} _sep_x The horizontal spacing between tiles on the tilemap.
/// @param {Real} _sep_y The vertical spacing between tiles on the tilemap.
function tile_generate_data(_sprite_id, _angle_data, _off_x = 0, _off_y = 0, _sep_x = 0, _sep_y = 0)
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
	
	instance_create(0, 0, obj_tile);
	
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
			_surface, _off_x + _xcell_size * (_i % TILE_SIZE), _off_y + _ycell_size * floor(_i / TILE_SIZE), TILE_SIZE, TILE_SIZE, false, false, 0, 0
		);
		
		sprite_collision_mask(_tile, true, 1, 0, 0, 0, 0, 0, 0);
		
		obj_tile.sprite_index = _tile;

		for (var _m = 0; _m < TILE_SIZE; _m++)
		{	
			for (var _n = 0; _n < TILE_SIZE; _n++)
			{
				if (collision_point(obj_tile.x + _m, obj_tile.y + _n, obj_tile, true, false))
				{
					_height_arr[_i][_m]++;
					_width_arr[_i][_n]++;
				}
			}
		}
		
		var _angle_index = _i - 1;
		
		if (_angle_index < _angle_data_length)
		{
			_angle_arr[_i] = math_get_angle_degree(_angle_data[_angle_index]);
		}
		
		sprite_delete(_tile);
	}
	
	surface_free(_surface);
	instance_destroy(obj_tile);
	
	if !global.tools_binary_collision
	{
		global.tile_height_data[? _sprite_id] = _height_arr;
		global.tile_width_data[? _sprite_id] = _width_arr;
		global.tile_angle_data[? _sprite_id] = _angle_arr;
	}
	else
	{
		var _prefix = sprite_get_name(_sprite_id);
		
		show_debug_message
		(
			"=============================================================================================================\n"
	      + "GENERATED COLLISION FOR " + _prefix + " IS SAVED INTO THE BINARY FILES. IT IS NOT REGISTERED IN THE GAME!\n"
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