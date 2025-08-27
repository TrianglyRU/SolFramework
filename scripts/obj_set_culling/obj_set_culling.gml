/// @self g_object
/// @description Sets the culling behavior.
/// @param {Enum.ACTIVEIF} _type The culling rule that determines when the object stays active.
function obj_set_culling(_type)
{
	cull_behaviour = _type;
}