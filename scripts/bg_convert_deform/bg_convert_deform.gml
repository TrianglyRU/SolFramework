/// @self
/// @description Initialises a background parallax object with scaling effects, replacing the specified layer. This function requires the assigned sprite to have "Separate Texture Page" enabled.
/// @param {String} _layer The name of the background layer to convert into an object.
/// @param {Real} _factor_x Horizontal parallax factor.
/// @param {Real} _factor_y Vertical parallax factor.
/// @param {Real} _scroll_x Horizontal scrolling speed multiplier.
/// @param {Real} _scroll_y Vertical scrolling speed multiplier.
/// @param {Real} _line_factor_x Target horizontal parallax factor at the bottom of the layer. Used to create a pseudo-3D effect by progressively changing the scroll factor per line.
/// @param {Real} _line_height Height of each scrolling line in pixels. Set to a negative value to disable the line scroll effect.
/// @param {Real} _scale_target_y Room-space y position at which the bottom of the layer will be scaled to; a recommended value for _factor_y will be printed to the console if it's currently set to 0. Set to a negative value to disable scaling. 
/// @param {Real} _anim_duration Duration of each animation frame in game steps.
function bg_convert_deform(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _line_factor_x, _line_height, _scale_target_y, _anim_duration)
{
	var _object = bg_convert(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _anim_duration);
	if (_object != noone)
	{
		_object.line_factor_x = _line_factor_x;
	    _object.line_height = _line_height;
		_object.scale_target_y = _scale_target_y;
		_object.scale_target_y_init = _scale_target_y;
	}
}