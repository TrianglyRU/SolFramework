// Inherit the parent event
event_inherited();
event_animator();

depth -= 2;
transition_flag = false;
star_index = 0;
timer = 0;
radius = 0;
animator.start(sprite_index, 0, 0, 2);