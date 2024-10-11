// Override draw
var _offset_x = (camera_get_x(view_current) + camera_get_width(view_current) * 0.5 - x) * (vd_scroll_speed);
var _offset_y = (camera_get_y(view_current) + camera_get_height(view_current) * 0.5 - y) * (vd_scroll_speed);

draw_sprite(sprite_index, image_index, x - _offset_x, y - _offset_y);