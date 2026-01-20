/// @self
/// @description			Deletes the camera and surface for the given viewport index.
/// @param {Real} _index	The viewport index.
function camera_delete(_index)
{
	view_visible[_index] = false;
	
	camera_destroy(view_camera[_index]);
	surface_free(view_surface_id[_index]);
	surface_free(obj_game.view_surface_palette[_index]);
	surface_free(obj_game.view_surface_final[_index]);
	
	obj_game.camera_data[_index] = undefined;
}