/// @self
/// @description Destroys a background object located on the specified layer, and removes that layer as well.
function bg_clear(_layer)
{
	with obj_game_layer
	{
		if layer_get_name(layer) == _layer
		{
			instance_destroy();
			break;
		}
	}
}