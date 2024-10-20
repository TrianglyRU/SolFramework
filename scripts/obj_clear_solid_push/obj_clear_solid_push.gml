/// @self
/// @description Clears the flag that forces a push animation on the specified player object, reverting to the default move animation.
/// @param {Id.Instance} _player The player object instance.
function obj_clear_solid_push(_player)
{
	with (_player)
	{
		if (set_push_anim_by != other.id)
		{
			return;
		}
		
		if (animation != ANIM.SPIN && animation != ANIM.SPINDASH)
		{
			animation = ANIM.MOVE;
		}
		
		set_push_anim_by = noone;
	}
}