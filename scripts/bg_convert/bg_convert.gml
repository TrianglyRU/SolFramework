/// @self
/// @description Initialises a simple background parallax object, replacing the specified layer. This function requires the layer to have an assigned sprite.
/// @param {String} _layer The name of the background layer to convert into an object.
/// @param {Real} _factor_x Horizontal parallax factor.
/// @param {Real} _factor_y Vertical parallax factor.
/// @param {Real} _scroll_x Horizontal scrolling speed multiplier.
/// @param {Real} _scroll_y Vertical scrolling speed multiplier.
/// @param {Real} _anim_duration Duration of each animation frame in game steps.
function bg_convert(_layer, _factor_x, _factor_y, _scroll_x, _scroll_y, _anim_duration)
{
	// If you want the vertical scrolling to perfectly align the background's bottom edge with the room's bottom edge,
	// use the following formula to calculate factor_y:
	// (background height - camera height) / (room height - camera height)
	
	var _bg_layer = layer_background_get_id(_layer);
	var _sprite_id = layer_background_get_sprite(_bg_layer);
	
	if _sprite_id == -1
	{
		return noone;
	}
	
	var _depth = layer_get_depth(_layer);
	var _new_layer = layer_create(_depth, _layer);
	var _object = instance_create_layer(0, 0, _new_layer, obj_layer);
	
	_object.sprite_index = _sprite_id;
	_object.visible = layer_get_visible(_layer);
	
	_object.htiled = layer_background_get_htiled(_bg_layer);
	_object.vtiled = layer_background_get_vtiled(_bg_layer);
	_object.offset_x = layer_get_x(_layer);
	_object.offset_y = layer_get_y(_layer);
	_object.factor_x = _factor_x;
    _object.factor_y = _factor_y;
	_object.scroll_mult_x = _scroll_x;
    _object.scroll_mult_y = _scroll_y;
	_object.anim_duration = _anim_duration;
	
	layer_destroy(_layer);
	sprite_set_offset(_sprite_id, 0, 0);
	
	return _object;
}