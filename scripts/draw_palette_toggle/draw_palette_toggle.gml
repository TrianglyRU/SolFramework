/// @self
/// @description Toggles colour palette replacement for all subsequent drawing calls.
/// @param {Bool} _enabled A boolean flag to enable or disable the colour palette replacement.
function draw_palette_toggle(_enabled)
{
	shader_set_uniform_i(global.sh_pal_active, _enabled);
}