// Inherit the parent event
event_inherited();

obj_set_priority(5);
obj_set_solid(16, sprite_height * 0.5);
obj_set_culling(ACTIVEIF.INBOUNDS_RESET);

retract_direction = sign(image_xscale);
retract_distance = 32;
retract_timer = 0;
retract_offset = 0;