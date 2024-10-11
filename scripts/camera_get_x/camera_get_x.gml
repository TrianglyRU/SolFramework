/// @self
/// @description Gets the adjusted x position of the camera for the given viewport index.
/// @param {Real} _index The viewport index.
/// @returns {Real}
function camera_get_x(_index)
{
    return camera_get_view_x(view_camera[_index]) + CAMERA_HORIZONTAL_BUFFER;
}