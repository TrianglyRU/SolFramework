/// @self
/// @description Resets BGM based on player state or plays default BGM.
/// @param {Asset.GMSound} _default_bgm The default BGM asset.
/// @param {Id.Instance} [_player] The player instance to determine BGM (default is noone).
/// @returns {Id.Sound}
function audio_reset_bgm(_default_bgm, _player = noone)
{
    if (_player == noone)
    {
        audio_play_bgm(_default_bgm);
    }
    else if (_player.super_timer > 0)
    {
        audio_play_bgm(snd_bgm_super);
    }
    else if (_player.item_inv_timer > 0)
    {
        audio_play_bgm(snd_bgm_invincibility);
    }
    else if (_player.item_speed_timer > 0)
    {
        audio_play_bgm(snd_bgm_highspeed);
    }
    else
    {
        audio_play_bgm(_default_bgm);
    }
}