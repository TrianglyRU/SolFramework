// Inherit the parent event
event_inherited();

depth = m_get_layer_depth(50);
outside_action = OUTSIDE_ACTION.RESPAWN;
retract_direction = sign(image_yscale);
retract_distance = 32;
retract_timer = 0;
retract_offset = 0;