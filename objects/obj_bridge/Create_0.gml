// Inherit the parent event
event_inherited();

log_size = 16;
log_size_half = floor(log_size / 2);
active_log = 0;
max_dip = 0;
angle = 0;
log_amount = floor(sprite_width / log_size);
	
for (var _i = 0; _i < log_amount; _i++) 
{
	log_x[_i] = x - log_amount * log_size_half + log_size * _i + log_size_half
	log_y[_i] = y;
	dip[_i] = _i < floor(log_amount / 2) ? (_i + 1) * 2 : (log_amount - _i) * 2;
}

solid_disable_balance = true;

obj_set_priority(4);
obj_set_solid(log_amount * log_size_half, log_size_half);
obj_set_culling(CULLING.SUSPEND);