/// @self
/// @description Gets the data of the camera for the given viewport index.
/// @param {Real} _index The viewport index.
/// @returns {Struct|Undefined}
function camera_get_data(_index)
{
    return obj_game.camera_data[_index];
}