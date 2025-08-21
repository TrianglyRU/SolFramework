/// @self
/// @description Creates a new camera and assigns it to a new surface, returning a struct containing its data. It will delete any existing camera assigned to the same index.
/// @param {Real} _index The index to assign the new camera to.
/// @param {Real} _width The horizontal resolution of the camera.
/// @param {Real} _height The vertical resolution of the camera.
/// @param {Real} _canvas_width The horizontal size of the surface.
/// @param {Real} _canvas_height The vertical size of the surface.
/// @param {Real} [_canvas_x] The horizontal offset of the surface on the screen (default is 0).
/// @param {Real} [_canvas_y] The vertical offset of the surface on the screen (default is 0).
function camera_new(_index, _width, _height, _canvas_width, _canvas_height, _canvas_x = 0, _canvas_y = 0)
{
	if (view_camera[_index] != -1)
	{
		camera_delete(_index);
	}
	
    var _camera_data =
    {
        index: _index,	
        allow_movement: true,
        target: noone,
        vel_x: 0,
        vel_y: 0,
        pos_x: 0,
        pos_y: 0,
        pos_x_prev: 0,
        pos_y_prev: 0,
        delay_x: 0,
        delay_y: 0,
        offset_x: 0,
        offset_y: 0,
		top_bound: 0,
        left_bound: 0,
        right_bound: room_width,
        bottom_bound: room_height,
        shake_offset: 0,
        shake_timer: 0,
        coarse_x: -1,
        coarse_y: -1,
        coarse_x_last: -1,
        coarse_y_last: -1,
        surface_x: _canvas_x,
        surface_y: _canvas_y,
        surface_w: _canvas_width + CAMERA_HORIZONTAL_BUFFER * 2,
        surface_h: _canvas_height
    };
	
    view_camera[_index] = camera_create_view(0, 0, _width + CAMERA_HORIZONTAL_BUFFER * 2, _height);
	view_visible[_index] = true;
	view_enabled = true;
	
    obj_game.camera_data[_index] = _camera_data;
	
	// Trigger custom Async Event
	var _map = ds_map_create();
	
	_map[? "event_type"] = "camera created";
	_map[? "camera_index"] = _index;
	
	event_perform_async(ev_async_system_event, _map);
}