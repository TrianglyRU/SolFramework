if (transition_flag && obj_framework.fade_state == FADESTATE.PLAINCOLOUR)
{	
	room_goto(rm_bonus);
	exit;
}

if (obj_framework.state == FWSTATE.PAUSED)
{
	exit;
}

if (timer >= 512)
{
	instance_destroy();
	exit;
}

if (timer >= 384)
{
	radius -= 0.25;
}
else if (timer < 128)
{
	radius += 0.25;
}

if (!transition_flag && timer >= 128 && obj_check_hitbox(player_get(0)))
{
	transition_flag = true;
	
	fade_perform_black(FADEROUTINE.OUT, 1);
	audio_stop_bgm(0.5);
	obj_set_culling(CULLING.NONE);
}

timer++;

var _radius = floor(radius);
var _angle = 90 * vd_star_id + timer * 12.65625;
var _x = dsin(_angle) * 512;
var _y = ((dcos(_angle) * 512) << 10) + _x * dsin(timer * 2.8125) * 1536;
var _dist_x = (_x << 12) * _radius;
var _dist_y = _y * _radius;

x = round(xstart + (_dist_x >> 21));
y = round(ystart + (_dist_y >> 21));