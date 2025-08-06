/// @description Toggle Fullscreen
if (window_get_fullscreen())
{
	window_set_fullscreen(false);
	window_set_cursor(cr_default);
}
else
{
	window_set_fullscreen(true);
	window_set_cursor(cr_none);
}