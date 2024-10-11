/// @self
/// @description Creates a new camera and assigns it to a new surface, returning a struct containing its data. It will delete any existing camera assigned to the same index.
/// @param {Real} _index The index to assign the new camera to.
/// @param {Real} _width The horizontal resolution of the camera.
/// @param {Real} _height The vertical resolution of the camera.
/// @param {Real} _canvas_width The horizontal size of the surface.
/// @param {Real} _canvas_height The vertical size of the surface.
/// @param {Real} [_pos_x] The initial x position of the camera in the room (default is 0).
/// @param {Real} [_pos_y] The initial y position of the camera in the room (default is 0).
/// @param {Real} [_canvas_x] The horizontal offset of the surface on the screen (default is 0).
/// @param {Real} [_canvas_y] The vertical offset of the surface on the screen (default is 0).
function camera_new(_index, _width, _height, _canvas_width, _canvas_height, _pos_x = 0, _pos_y = 0, _canvas_x = 0, _canvas_y = 0)
{
    camera_delete(_index);
	
    var _camera_data =
    {
        index: _index,	
        allow_movement: true,
        target: noone,
        vel_x: 0,
        vel_y: 0,
        pos_x: _pos_x,
        pos_y: _pos_y,
        pos_x_prev: 0,
        pos_y_prev: 0,
        delay_x: 0,
        delay_y: 0,
        offset_x: 0,
        offset_y: 0,
        bound_left: 0,
        bound_upper: 0,
        bound_right: room_width,
        bound_lower: room_height,
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
    
    view_camera[_index] = camera_create_view(_pos_x, _pos_y, _width + CAMERA_HORIZONTAL_BUFFER * 2, _height);
    view_visible[_index] = true;
    
    obj_framework.camera_data[_index] = _camera_data;
}