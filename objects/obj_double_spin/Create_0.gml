// Inherit the parent event
event_inherited();

depth = draw_depth(0);
ignored_game_state = GAME_STATE.STOP_OBJECTS;
attack_timer = 14;
player = noone;
animator.start(sprite_index, 0, 5, 1);