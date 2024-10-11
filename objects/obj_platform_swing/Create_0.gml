#macro SWING_CHAIN_SIZE 16

// Inherit the parent event
event_inherited();

osc_angle = 0;
distance = vd_chain_amount * SWING_CHAIN_SIZE - SWING_CHAIN_SIZE * 0.5;
sprite_chain = spr_platform_swing_chain;
sprite_pendulum = spr_platform_swing_bob;
sprite_index = spr_platform_swing_base;

obj_set_priority(4);
obj_set_solid(24, 8);
obj_set_culling(CULLING.ORIGINSUSPEND);