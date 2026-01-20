/// @self
/// @description								Sets the data displayed in Discord Rich Presence. Requires a configured Application ID for your game.
/// @param {String|Undefined} _upper_text		The main line of text to display. Pass undefined if no changes are required.
/// @param {String|Undefined} _lower_text		The secondary line of text to display. Pass undefined if no changes are required.
/// @param {String|Undefined} _large_image_key	The key of the main image. Pass undefined if no changes are required.
/// @param {String|Undefined} _small_image_key	The key of the secondary image. Pass undefined if no changes are required.
function discord_set_data(_upper_text, _lower_text, _large_image_key, _small_image_key)
{
	if !global.discord_ready
	{
		return;
	}
	
	if _lower_text != undefined
	{
		global.discord_data[0] = _lower_text;
	}
	
	if _upper_text != undefined
	{
		global.discord_data[1] = _upper_text;
	}
	
	if _large_image_key != undefined
	{
		global.discord_data[2] = _large_image_key;
	}
	
	if _small_image_key != undefined
	{
		global.discord_data[3] = _small_image_key;
	}
	
	np_setpresence(global.discord_data[0], global.discord_data[1], global.discord_data[2], global.discord_data[3]);
}
