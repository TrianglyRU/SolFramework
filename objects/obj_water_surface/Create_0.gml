// Inherit the parent event
event_inherited();

obj_set_culling(ACTIVEIF.ENGINE_RUNNING);
obj_set_anim(sprite_index, 16, 0, 0);

depth = RENDERER_DEPTH_HIGHEST - 1;