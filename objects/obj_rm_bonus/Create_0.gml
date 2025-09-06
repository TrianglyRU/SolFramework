/// @method return_to_prev_room()
return_to_prev_room = function()
{
	room_goto(global.previous_rooid);
};

rings_earned = 0;
continue_earned = false;

audio_play_bgm(snd_bgm_bonus);
bg_convert("Background", 0, 0, 0.25, 0.25, 0);
discord_set_data("BONUS STAGE", "", "", undefined);
fade_perform_black(FADE_DIRECTION.IN, 1);