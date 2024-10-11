#macro BUMPER_FORCE 7 
	
// Inherit the parent event
event_inherited();

hits_left = -1;	
	
obj_set_priority(1);
obj_set_hitbox(8, 8);
obj_set_culling(CULLING.SUSPEND);