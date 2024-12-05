if (room == rm_startup)
{
	return;
}

#region RENDERER

gpu_set_blendmode_ext_sepalpha(bm_one, bm_inv_src_alpha, bm_one, bm_one);
gpu_set_blendenable(false);

// Draw view_surface_ids
for (var _i = 0; _i < CAMERA_COUNT; _i++)
{
    var _camera_data = camera_get_data(_i);
	
    if (_camera_data != undefined && surface_exists(view_surface_id[_i]))
    {
        draw_surface_part(view_surface_id[_i], CAMERA_HORIZONTAL_BUFFER, 0, _camera_data.surface_w - CAMERA_HORIZONTAL_BUFFER * 2, _camera_data.surface_h, _camera_data.surface_x, _camera_data.surface_y);
    }
}

gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);

#endregion