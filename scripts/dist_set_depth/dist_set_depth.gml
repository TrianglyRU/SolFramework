/// @self
/// @description Applies a distortion effect to the specified layer and all layers behind it (by depth).
/// @param {String} _layer The name of the layer at which depth the distortion will be applied.
/// @param {Array<Real>|undefined} _data1 The first set of distortion data values.
/// @param {Array<Real>|undefined} _data2 The second set of distortion data values.
/// @param {Real} _factor The vertical parallax factor of the distortion effect.
/// @param {Real} _speed The speed at which the distortion moves or animates.
/// @param {Real} _range_start The top boundary of the distortion area.
/// @param {Real} _range_end The bottom boundary of the distortion area.
function dist_set_depth(_layer, _data1, _data2, _factor, _speed, _range_start, _range_end)
{
	var _effect = fx_create("_filter_layer_distortion");
	
	if _effect == -1
	{
		return;
	}
	
	var _data =
    {
		layers: [_layer],
        effect: _effect,	
		spd: _speed,
		factor: _factor,
		range_start: _range_start,
		range_end: _range_end,
		values_a: _data1,
		values_b: _data2,
		offset: 0
    };
	
	layer_set_fx(_layer, _effect);	
	ds_list_add(obj_game.distortion_data, _data);
}