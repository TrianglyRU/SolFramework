var _camera_index = async_get("camera deleted", "camera_index");

if _camera_index != undefined
{
	surface_free(shader_surface[_camera_index]);
}