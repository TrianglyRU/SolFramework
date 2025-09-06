var _target_bg = iv_bg_index;

for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
	var _camera = camera_get_data(_i);
	
	if _camera == undefined
	{
		continue;
	}
	
	var _width = camera_get_width(_i);
	var _height = camera_get_height(_i);
	
	var _x = _camera.raw_x + _width * 0.5;
	var _y = _camera.raw_y + _height * 0.5;
	
	if point_in_rectangle(_x, _y, bbox_left, bbox_top, bbox_right, bbox_bottom)
	{
		with obj_layer
		{
			if layer_get_name(layer) != "Inside"
			{
				visible = _target_bg == 0;
			}
			else
			{
				visible = _target_bg == 1;
			}
		}
	}
}