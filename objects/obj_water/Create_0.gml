// Inherit the parent event
event_inherited();
event_animator();

depth = RENDER_DEPTH_PRIORITY - 1;
image_xscale = 1;
image_yscale = 1;
ignored_game_state = GAME_STATE.STOP_OBJECTS;
current_level = ystart;
target_level = ystart;
animator.start(spr_water, 0, 0, 16);

obj_game.distortion_bound = ystart;
obj_game.palette_bound = ystart;