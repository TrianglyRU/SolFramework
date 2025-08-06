// Inherit the parent event
event_inherited();

// Override data
vel_charge_target = 8;
vel_charge_acc = 0.125;
animation_data = [sprite_index, spr_amy_idle, spr_amy_walk, spr_amy_run, spr_amy_dash];
y += 2;

obj_set_anim(sprite_index, 6, 0, 0);