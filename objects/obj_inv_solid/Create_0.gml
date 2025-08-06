// Inherit the parent event
event_inherited();

obj_set_solid(floor(sprite_width * 0.5), floor(sprite_height * 0.5));
obj_set_culling(ACTIVEIF.INBOUNDS);