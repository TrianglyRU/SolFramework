// Inherit the parent event
event_inherited();
event_culler();

swap_background = -1;

switch room
{
	case rm_stage_dwz:
		
		swap_background = function(_camera_index)
		{
			var _index = iv_index;
			
			with obj_layer
			{
				if layer_get_name(layer) != "Inside"
				{
					rendered[_camera_index] = _index == 0;
				}
				else
				{
					rendered[_camera_index] = _index != 0;
				}
			}
		}	
	
	break;
}