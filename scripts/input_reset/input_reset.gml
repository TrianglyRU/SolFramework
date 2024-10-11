/// @self
/// @description Resets all input values in the provided structure to false.
/// @param {Struct} _struct
function input_reset(_struct)
{
	var _keys = variable_struct_get_names(_struct);
	
	for (var _i = array_length(_keys) - 1; _i >= 0; _i--) 
	{
		_struct[$ _keys[_i]] = false;
	}
}