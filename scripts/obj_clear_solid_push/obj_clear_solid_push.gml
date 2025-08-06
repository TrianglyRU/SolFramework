/// @self
/// @description Clears the flag that forces a push animation on the specified player object, reverting to the default move animation.
/// @param {Id.Instance} _player The player object instance.
function obj_clear_solid_push(_player)
{
	if (_player.set_push_anim_by != id)
	{
		return;
	}
	
	if (_player.animation != ANIM.SPIN && _player.animation != ANIM.SPINDASH)
	{
		_player.animation = ANIM.MOVE;
	}
		
	_player.set_push_anim_by = noone;
}