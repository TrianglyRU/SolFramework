/// @self obj_player
/// @function scr_player_update_status()
function scr_player_update_status()
{
	gml_pragma("forceinline");
	
	if (animation == ANIM.SKID)
	{
		if (skid_timer++ % 4 == 0)
		{
			instance_create(x, y + radius_y + 1, obj_dust_skid);
		}
	}

	if (inv_frames > 0)
	{
		image_alpha = (inv_frames & 4 > 0) * 1.0;
		if (--inv_frames == 0)
		{
			image_alpha = 1.0;
		}
	}

	if (item_speed_timer > 0)
	{
		if (--item_speed_timer == 0 && audio_is_playing(snd_bgm_highspeed))
		{
			audio_reset_bgm(obj_rm_stage.bgm_track, id);
		}
	}

	if (item_inv_timer > 0)
	{
		if (--item_inv_timer == 0 && audio_is_playing(snd_bgm_invincibility))
		{
			audio_reset_bgm(obj_rm_stage.bgm_track, id);
		}
	}
	
	if (super_timer > 0)
	{
		if (action == ACTION.TRANSFORM)
		{
			if (--transform_timer == 0)
			{
				state = PLAYERSTATE.DEFAULT;
				reset_substate();
				instance_create(x, y, obj_star_super, { vd_target_player: id });
			}
		}
	
		if (super_timer == 1)
		{
			if (--global.player_rings <= 0)
			{
				global.player_rings = 0;
				inv_frames = 1;
				super_timer = 0;
				
				if (!audio_is_playing(snd_bgm_drowning))
				{
					audio_reset_bgm(obj_rm_stage.bgm_track, id);
				}
			}
			else
			{
				super_timer = 61;
			}
		}
		else
		{
			super_timer--;
		}
	}
	
	if (obj_game.frame_counter == 36000 && player_index == 0)
	{
		kill();
	}
}