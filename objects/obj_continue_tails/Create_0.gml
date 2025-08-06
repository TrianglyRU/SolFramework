// Inherit the parent event
event_inherited();

// Override data
vel_charge_target = 8;
vel_charge_acc = 0.125;
animation_data = [sprite_index, spr_tails_idle, spr_tails_walk, spr_tails_run, spr_tails_dash];
y += 3;

obj_set_anim(sprite_index, 24, 0, 0);