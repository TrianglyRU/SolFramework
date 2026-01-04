// Feather ignore GM2022
var _w = x - bbox_left;
var _h = y - bbox_top;

collision_rectangle_list(xprevious - _w, yprevious - _h - 8, xprevious + _w - 1, yprevious + _h - 1, obj_object, false, true, synced_objects, false);

// Update position on load
event_perform(ev_step, ev_step_normal);