if (update_timer)
{
	local_timer = obj_game.frame_counter;
}

dynamic_frame = floor((obj_game.frame_counter - 1) / 8) % 2;

var _min = 9;
var _sec = 59;
var _msc = 59;

if (local_timer < 35999)
{
	_min = floor(local_timer / 3600);
	_sec = floor((local_timer - _min * 3600) / 60);
	_msc = floor(local_timer % 60 / 3 * 5);
}

if (!global.cd_timer)
{
	timer_string = string(_min) + ":" + ((_sec > 9) ? "" : "0") + string(_sec);
}
else
{
	timer_string = string(_min) + "'" + ((_sec > 9) ? "" : "0") + string(_sec) + ";" + ((_msc > 9) ? "" : "0") + string(_msc);
}