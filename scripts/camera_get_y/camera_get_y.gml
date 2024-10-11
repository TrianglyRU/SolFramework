/// @self
/// @description Gets the y position of the camera for the given viewport index.
/// @param {Real} _index The viewport index.
/// @returns {Real}
function camera_get_y(_index)
{
    return camera_get_view_y(view_camera[_index]);
}