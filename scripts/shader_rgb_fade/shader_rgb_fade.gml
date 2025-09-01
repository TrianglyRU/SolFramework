/// @self
/// @description Applies an RGB fade to subsequent draw calls using the fade data defined in obj_game.
function shader_rgb_fade()
{
	var _timer = obj_game.fade_timer;
	var _type = obj_game.fade_type;
	
	if _type == FADE_TYPE.DULL_ORDER || _type == FADE_TYPE.DULL_SYNC || _type == FADE_TYPE.FLASH_ORDER || _type == FADE_TYPE.FLASH_SYNC
	{
		_timer = round(_timer / 3);
	}	
	
	var _u_timer = shader_get_uniform(sh_rgb_fade, "u_timer");
	var _u_type = shader_get_uniform(sh_rgb_fade, "u_type");
	
	shader_set(sh_rgb_fade);
	shader_set_uniform_f(_u_timer, _timer);
	shader_set_uniform_i(_u_type, _type);
}