/// @self
/// @description The same as regular instance_create() function, but marks a new object as a child of the object the function was called from to handle the culling properly.
/// @param {Real} _x The x position for the instance.
/// @param {Real} _y The y position for the instance.
/// @param {Asset.GMObject} _object The object to create an instance of.
/// @param {Struct} [_vars] A structure for initialising variables (default is {}).
/// @returns {Id.Instance}
function instance_create_child(_x, _y, _object, _vars = {})
{
	var _new_obj = instance_create(_x, _y, _object, _vars);
	
	_new_obj.cull_behaviour = ACTIVEIF.OBJECTS_RUNNING;
	_new_obj.cull_parent = id;
	
	return _new_obj;
}