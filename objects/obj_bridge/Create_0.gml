// Inherit the parent event
event_inherited();

solid_balance = false;

log_size = 16;
log_size_half = floor(log_size * 0.5);
active_log = 0;
max_dip = 0;
angle = 0;
log_amount = floor(sprite_width / log_size);
log_x = [];
log_y = [];
dip = [];
depth = m_get_layer_depth(40);

for (var _i = 0; _i < log_amount; _i++) 
{
	log_x[_i] = x - log_amount * log_size_half + log_size * _i + log_size_half
	log_y[_i] = y;
	dip[_i] = _i < floor(log_amount * 0.5) ? (_i + 1) * 2 : (log_amount - _i) * 2;
}