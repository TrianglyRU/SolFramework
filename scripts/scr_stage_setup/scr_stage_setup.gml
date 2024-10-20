/// @function scr_stage_setup()
/// @self obj_rm_stage
function scr_stage_setup()
{
	switch (room)
	{
		#region TEST STAGE ZONE
		
		case rm_stage_tsz0:
		
			setup_level(98, "TEST STAGE", 0, snd_bgm_ghz, [spr_animal_flicky, spr_animal_pocky], 992, -1, rm_stage_tsz1, false);
			
			bg_add_layer(spr_bg_ghz_00, 0,   32, -32,  0, -1.0,  0, 0.375, -0.03125);
			bg_add_layer(spr_bg_ghz_00, 32,  16,  0,   0, -0.5,  0, 0.375, -0.03125);
			bg_add_layer(spr_bg_ghz_00, 48,  16,  16,  0, -0.25, 0, 0.375, -0.03125);
			bg_add_layer(spr_bg_ghz_00, 64,  48,  32,  0,  0,    0, 0.375, -0.03125);
			bg_add_layer(spr_bg_ghz_00, 112, 40,  80,  0,  0,    0, 0.5,   -0.03125);
			bg_add_layer(spr_bg_ghz_00, 152, 104, 120, 0,  0,    0, 0.5,   -0.03125);
			bg_set_perspective_x(0.9921875, 1);
			
			sprite_set_animation(spr_asset_ghz_00, 16);
			sprite_set_animation(spr_asset_ghz_01, 8);
			
			pal_load_local(spr_pal_ghz_primary_local, undefined);
			
			tile_load_data_binary("widths_s1", "heights_s1", "angles_s1", "CollisionA", "CollisionB");
			
			texture_prefetch("texgroup_ghz_scenery");
			
			player_spawn(80, 964, global.player_main, "Objects");
			player_spawn(64, 965, global.player_cpu, "Objects");
			
		break;
		
		case rm_stage_tsz1:
		
			setup_level(99, "TEST STAGE", 1, snd_bgm_ehz, [spr_animal_flicky, spr_animal_ricky], room_height, -1, rm_stage_tsz2, false);
			
			dist_set_bg(dist_get_data(EFFECTDATA.EHZ), undefined, 0.125, 80, 111);
			
			bg_add_layer(spr_bg_ehz_00, 0,   112, 0,   0, 0, 0, 0.015625, 0);
			bg_add_layer(spr_bg_ehz_00, 112, 16,  112, 0, 0, 0, 0.0625,   0);
			bg_add_layer(spr_bg_ehz_00, 128, 16,  128, 0, 0, 0, 0.09375,  0);
			bg_add_layer(spr_bg_ehz_00, 144, 29,  144, 0, 0, 0, 0.09375,  0);
			bg_set_perspective_x(0.3515625, 1);
			bg_add_layer(spr_bg_ehz_00, 173, 83, 173, 0, 0, 0, 0.3515625, 0);
			bg_set_perspective_x(1.00, 3);
			
			sprite_set_animation(spr_asset_ehz_00, 4);
			sprite_set_animation(spr_asset_ehz_01, 2);
			sprite_set_animation(spr_asset_ehz_02, 4);
			sprite_set_animation(spr_asset_ehz_03, 8);
			sprite_set_animation(spr_asset_ehz_04, 2);
			
			pal_load_local(spr_pal_ehz_primary_local, undefined);
			
			tile_load_data_binary("widths_s2", "heights_s2", "angles_s2", "CollisionA", "CollisionB");
			
			texture_prefetch("texgroup_ehz_scenery");
			
			player_spawn(96, 676, global.player_main, "Objects");
			player_spawn(80, 676, global.player_cpu, "Objects");
			
		break;
		
		case rm_stage_tsz2:
			
			// Use S3K physics
			global.player_physics = PHYSICS.SK;
			
			setup_level(100, "TEST STAGE", 2, snd_bgm_aiz, [spr_animal_flicky, spr_animal_cucky], 1136, 1284, rm_level_select, true);
			
			dist_set_fg(undefined, dist_get_data(EFFECTDATA.AIZFG_WATER), -0.5, 0, room_height, ["GraphicsA", "GraphicsB"]);
			dist_set_bg(undefined, dist_get_data(EFFECTDATA.AIZBG_WATER), -0.25, 402, 896);
			
			bg_add_layer(spr_bg_aiz_00, 0,   208, 0,   0, -0.1875,  0, 0.375,      0.5);
			bg_add_layer(spr_bg_aiz_00, 208, 32,  208, 0, -0.15625, 0, 0.3125,     0.5);
			bg_add_layer(spr_bg_aiz_00, 240, 56,  240, 0, -0.125,   0, 0.25,       0.5);
			bg_add_layer(spr_bg_aiz_00, 296, 36,  296, 0, -0.09375, 0, 0.1875,     0.5);
			bg_add_layer(spr_bg_aiz_00, 332, 20,  332, 0, -0.0625,  0, 0.125,      0.5);
			bg_add_layer(spr_bg_aiz_00, 352, 16,  352, 0, -0.03125, 0, 0.0625,     0.5);
			
			if (global.player_main != PLAYER.KNUCKLES)
			{
				bg_add_layer(spr_bg_aiz_00, 368, 16, 368, 0, 0, 0, 0.03125,    0.5);
				bg_add_layer(spr_bg_aiz_00, 384, 16, 384, 0, 0, 0, 0.03515625, 0.5);
				bg_set_perspective_x(0.1484375, 1);
				
				// Cancel palette swap
				pal_set_index_local([7, 8], 0);
			}
			else
			{
				layer_background_blend(layer_background_get_id("Background"), $FF4900);
			}
			
			bg_add_layer(spr_bg_aiz_00, 400, 12,  400, 0, 0, 0, 0.4375, 0.5);
			bg_add_layer(spr_bg_aiz_00, 412, 6,   412, 0, 0, 0, 0.5,    0.5);
			bg_add_layer(spr_bg_aiz_00, 418, 14,  418, 0, 0, 0, 0.5625, 0.5);
			bg_add_layer(spr_bg_aiz_00, 432, 80,  432, 0, 0, 0, 0.625,  0.5);
			bg_add_layer(spr_bg_aiz_00, 512, 32,  512, 0, 0, 0, 0.5625, 0.5);
			bg_add_layer(spr_bg_aiz_00, 544, 344, 544, 0, 0, 0, 0.5,    0.5);
			
			sprite_set_animation(spr_asset_aiz_00, 4);
			sprite_set_animation(spr_asset_aiz_01, 2);
			sprite_set_animation(spr_asset_aiz_02, 2);
			
			pal_load_local(spr_pal_aiz_primary_local, spr_pal_aiz_secondary_local);
			
			tile_load_data_binary("widths_s3", "heights_s3", "angles_s3", "CollisionA", "CollisionB");
			
			texture_prefetch("texgroup_aiz_scenery");
			
			player_spawn(192, 1069, global.player_main, "Objects");
			player_spawn(176, 1069, global.player_cpu, "Objects");
			
		break;
		
		#endregion
	}
}