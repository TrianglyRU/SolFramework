// Inherit the parent event
event_inherited();
event_animator();

depth -= 2;
star_index = 0;
timer = 0;
radius = 0;
transition_flag = false;
animator.start(sprite_index, 0, 0, 2);