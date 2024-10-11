/// @self
/// @description Loads palette data into the "local" slot from two sprite textures.
/// @param {Asset.GMSprite|Undefined} _primary The primary palette sprite.
/// @param {Asset.GMSprite|Undefined} _secondary The secondary palette sprite.
function pal_load_local(_primary, _secondary)
{
	var _tex, _uvs, _texel_x, _texel_y;
	
	if (_primary != undefined)
	{
		_tex = sprite_get_texture(_primary, 0);
		_uvs = sprite_get_uvs(_primary, 0);
		_texel_x = texture_get_texel_width(_tex);
		_texel_y = texture_get_texel_height(_tex);
		
		obj_framework.palette_data[2] = [_tex, _texel_x, _texel_y, _uvs[0] + _texel_x / 2, _uvs[1] + _texel_y / 2, _uvs[3]];
	}
	
	if (_secondary != undefined)
	{
		_tex = sprite_get_texture(_secondary, 0);
		_uvs = sprite_get_uvs(_secondary, 0);
		_texel_x = texture_get_texel_width(_tex);
		_texel_y = texture_get_texel_height(_tex);

		obj_framework.palette_data[3] = [_tex, _texel_x, _texel_y, _uvs[0] + _texel_x / 2, _uvs[1] + _texel_y / 2, _uvs[3]];
	}
}