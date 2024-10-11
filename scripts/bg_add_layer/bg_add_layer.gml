/// @self
/// @description Adds a parallax background layer to the current room.
/// @param {Asset.GMSprite} _sprite_id The sprite asset for the layer.
/// @param {Real} _node_y The y position of the top edge of the area to draw on the sprite.
/// @param {Real} _height_y The height of the drawing area.
/// @param {Real} _offset_y The vertical offset of the layer.
/// @param {Real} _anim_duration Duration of each frame's animation in game steps.
/// @param {Real} _scroll_vel_x Horizontal scroll speed of the layer.
/// @param {Real} _scroll_vel_y Vertical scroll speed of the layer.
/// @param {Real} _factor_x Horizontal parallax factor (smaller values = further from camera).
/// @param {Real} _factor_y Vertical parallax factor (smaller values = further from camera).
function bg_add_layer(_sprite_id, _node_y, _height_y, _offset_y, _anim_duration, _scroll_vel_x, _scroll_vel_y, _factor_x, _factor_y)
{
    var _sprite_texture = sprite_get_texture(_sprite_id, 0);
    
    with (obj_framework)
    {
        bg_parallax_data[bg_layer_count] =
        {
            sprite: _sprite_id,
            node_y: _node_y,
            height_y: _height_y,
            offset_y: _offset_y,
            factor_x: _factor_x,
            factor_y: _factor_y,
            scroll_vel_x: _scroll_vel_x,
            scroll_vel_y: _scroll_vel_y,
            scroll_x: 0,
            scroll_y: 0,
            field_line_height: 0,
            field_line_step: 0,
            anim_duration: _anim_duration,
            tex_width: sprite_get_width(_sprite_id),
            map_size_x: 1 / texture_get_texel_width(_sprite_texture),
            map_size_y: 1 / texture_get_texel_height(_sprite_texture)
        };
    
        if (bg_min_factor_y == 0 || _factor_y < bg_min_factor_y)
        {
            bg_min_factor_y = _factor_y;
        }
        
        bg_layer_count++;
    }
    
    sprite_set_offset(_sprite_id, 0, 0);
}