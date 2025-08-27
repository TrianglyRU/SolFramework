function instance_animation_start(_spriteid, _start_frame, _loopback, _frame_durtaion)
{
	image_speed = 0;
	image_index = _start_frame;
	sprite_index = _spriteid;
	
	image_duration = _frame_durtaion;
	image_timer = _frame_durtaion;
	image_loopback = _loopback;
	sprite_index_advanced = _spriteid;
	sprite_play_count = 0;
	
}