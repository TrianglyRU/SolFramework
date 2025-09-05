// Inherit the parent event
event_inherited();
event_animator();

depth = draw_depth(30);
ignored_game_state = GAME_STATE.STOP_OBJECTS;
player = noone;
animator.start(sprite_index, 0, 0, 3);