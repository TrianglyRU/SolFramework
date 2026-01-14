// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

#macro CHOMPY_VEL_Y_DEFAULT -9.75

vel_x = 0;
vel_y = 0;
angle = 0;
clear_jump = true;
animator.start(sprite_index, 0, 0, 8);