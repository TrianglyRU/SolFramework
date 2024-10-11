/// @self
/// @description Gets the vertical resolution of the camera for the given viewport index.
/// @param {Real} _index The viewport index.
/// @returns {Real}
function camera_get_height(_index)
{
	return camera_get_view_height(view_camera[_index]);
}