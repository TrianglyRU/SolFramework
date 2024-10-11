// Override draw	
var _scale_x = vd_flip_x ? -1 : 1;
var _scale_y = vd_flip_y ? -1 : 1;
var _x = x - floor(vd_width / 2) * _scale_x;
var _y = y - floor(vd_height / 2) * _scale_y;
	
draw_sprite_part_ext
(
	vd_sprite, vd_frame_index, vd_x, vd_y, vd_width, vd_height, floor(_x), floor(_y), _scale_x, _scale_y, c_white, 1.0
);