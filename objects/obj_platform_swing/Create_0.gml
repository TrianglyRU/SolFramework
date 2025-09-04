// Inherit the parent event
event_inherited();

#macro SWING_CHAIN_SIZE 16

osc_angle = 0;
distance = iv_chains * SWING_CHAIN_SIZE - SWING_CHAIN_SIZE * 0.5;
sprite_chain = spr_platform_swing_chain;
sprite_pendulum = spr_platform_swing_bob;
sprite_index = spr_platform_swing_base;
depth = m_get_layer_depth(40);