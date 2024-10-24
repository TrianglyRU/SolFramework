/// @self
/// @description Creates a new instance of the specified object, with optional variable initialisation and parent assignment.
/// @param {Real} _x The x position for the instance.
/// @param {Real} _y The y position for the instance.
/// @param {Asset.GMObject} _object The object to create an instance of.
/// @param {Struct} [_vars] A structure for initialising variables (default is {}).
/// @param {Id.Instance} [_parent] The parent instance for culling (default is noone).
/// @returns {Id.Instance}
function instance_create(_x, _y, _object, _vars = {}, _parent = noone)
{
	var _new_obj = instance_create_depth(_x, _y, depth, _object, _vars);
	
	if (_parent != noone && object_get_parent(object_index) == obj_instance)
	{
		with (_new_obj)
		{
			cull_behaviour = CULLING.ACTIVE;
			cull_parent = _parent;
		}
		
		// Set a new culling type for the parent
		cull_behaviour = CULLING.RESPAWN;
	}
	
	return _new_obj;
}