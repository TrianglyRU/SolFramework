// Inherit the parent event
event_inherited();

depth = RENDERER_DEPTH_HIGHEST;
image_index = vd_is_long_waterfall ? 1 : 0;
timer = 0;

obj_set_culling(ACTIVEIF.INBOUNDS);