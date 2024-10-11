/// @self
/// @description Deletes the camera and surface for the given viewport index.
/// @param {Real} _index The viewport index.
function camera_delete(_index)
{
	view_visible[_index] = false;
	
    if (surface_exists(view_surface_id[_index]))
    {
        surface_free(view_surface_id[_index]);
    }
	
	camera_destroy(view_camera[_index]);
    
    obj_framework.camera_data[_index] = undefined;
}