var _event = async_load[? "event_type"];

if _event == "camera deleted"
{
	surface_free(shader_surface[async_load[? "camera_index"]]);
}