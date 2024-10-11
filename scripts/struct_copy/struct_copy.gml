/// @self
/// @description Creates a duplicate of a given struct, preserving its properties.
/// @param {Struct} _struct The struct object to copy.
/// @returns {Struct}
function struct_copy(_struct)
{
    var _keys = variable_struct_get_names(_struct);
    var _length = array_length(_keys);
	var _new_struct = {};
    var _key, _value;
	
    for (var _i = _length - 1; _i >= 0; _i--) 
    {
        _key = _keys[_i];
        _value = _struct[$ _key];
        _new_struct[$ _key] = _value;
    }
	
    return _new_struct;
}