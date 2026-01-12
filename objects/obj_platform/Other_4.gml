// Feather ignore GM2022
collision_rectangle_list(bbox_left, bbox_top - 8, bbox_right - 1, bbox_bottom - 1, obj_object, false, true, synced_objects, false);

// Update position on load
event_perform(ev_step, ev_step_normal);