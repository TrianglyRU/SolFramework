// Inherit the parent event
event_inherited();

enum ANIMAL_STATE
{
	APPEAR,
	MOVE,
	CAPSULE
}

outside_action = OUTSIDE_ACTION.DESTROY;

state = ANIMAL_STATE.APPEAR;
state_timer = 0;
grv = 0.21875;
vel_x = 0;
vel_y = -4;
vel_x_bounce = 0;
vel_y_bounce = 0;

depth = m_get_layer_depth(70);

if instance_exists(obj_rm_stage)
{
	var _animal_count = array_length(obj_rm_stage.animal_set);
	
	if _animal_count > 0
	{
	    sprite_index = obj_rm_stage.animal_set[irandom(_animal_count - 1)];
	}
}

switch (sprite_index)
{
    case spr_animal_flicky:
	
        vel_x_bounce = 3;
        vel_y_bounce = -4;
		
    break;
	
    case spr_animal_pocky:
	
        vel_x_bounce = 2;
        vel_y_bounce = -4;
		
    break;
	
    case spr_animal_cucky:
	
        vel_x_bounce = 2;
        vel_y_bounce = -3;
		
    break;
	
    case spr_animal_pecky:
	
        vel_x_bounce = 1.5;
        vel_y_bounce = -3;
		
    break;
	
    case spr_animal_picky:
	
        vel_x_bounce = 1.75;
        vel_y_bounce = -3;
		
    break;
	
    case spr_animal_ricky:
	
        vel_x_bounce = 2.5;
        vel_y_bounce = -3.5;
		
    break;
	
    case spr_animal_rocky:
	
        vel_x_bounce = 1.25;
        vel_y_bounce = -1.5;
		
	break;
}