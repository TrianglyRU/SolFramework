/// @self
/// @description Checks if the provided array is not null and has elements.
/// @param {Any} _array The array to check for null and length.
/// @returns {Bool}
function is_not_null_array(_array)
{
    return is_array(_array) && array_length(_array) > 0;
}