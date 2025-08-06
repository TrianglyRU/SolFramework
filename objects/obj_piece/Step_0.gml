if vd_wait_time > 0
{
    vd_wait_time--;
    return;
}

visible = vd_do_flicker ? obj_game.frame_counter % 2 == 0 : true;
x += vd_vel_x;
y += vd_vel_y;
vd_vel_y += 0.21875;