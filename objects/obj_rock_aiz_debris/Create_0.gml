// Inherit the parent event
event_inherited();

depth = RENDERER_DEPTH_HIGHEST;

obj_set_culling(CULLING.REMOVE);
obj_set_anim(sprite_index, 3, image_index % image_number, 0);