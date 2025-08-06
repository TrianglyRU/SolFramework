if (cull_behaviour == ACTIVEIF.ALWAYS && obj_game.state == GAMESTATE.NORMAL)
{
	obj_set_culling(ACTIVEIF.INBOUNDS);
}

var _target_bg = vd_bg_id;
for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera = camera_get_data(_i);
	if (_camera == undefined)
	{
		continue;
	}
	
	var _width = camera_get_width(_i);
	var _height = camera_get_height(_i);
	
	var _x = _camera.pos_x + _width * 0.5;
	var _y = _camera.pos_y + _height * 0.5;
	
	if (_x >= bbox_left && _x < bbox_right && _y >= bbox_top && _y < bbox_bottom)
	{
		with (obj_game_layer)
		{
			if (layer_get_name(layer) != "Inside")
			{
				visible = (_target_bg == 0);
			}
			else
			{
				visible = (_target_bg == 1);
			}
		}
	}
}