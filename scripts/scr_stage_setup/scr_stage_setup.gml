/// @self obj_rm_stage
/// @function scr_stage_setup()
function scr_stage_setup()
{
	switch (room)
	{
		#region GREEN HILL
		
		case rm_stage_ghz0:
		
			// Use S1 physics (reverts back to default on room end)
			global.player_physics = PHYSICS.S1;
			
			setup_level(97, "GREEN HILL", 0, snd_bgm_ghz, [spr_animal_flicky, spr_animal_pocky], 992, -1, rm_stage_ehz0, false);
			
			bg_convert("Clouds_1", 0.375, -0.03125, -1.0, 0, 0);
			bg_convert("Clouds_2", 0.375, -0.03125, -0.5, 0, 0);
			bg_convert("Clouds_3", 0.375, -0.03125, -0.25, 0, 0);
			bg_convert("Mountains_1", 0.375, -0.03125, 0, 0, 0);
			bg_convert("Mountains_2", 0.5, -0.03125, 0, 0, 0);
			bg_convert_deform("Lake", 0.5, -0.03125, 0, 0, 0.9921875, 1, -1, 0);
			
			pal_load(spr_palette_ghz_a, undefined);
			
			sprite_set_animation(spr_asset_ghz_00, 16);
			sprite_set_animation(spr_asset_ghz_01, 8);
			
			tile_load_data_binary("widths_s1", "heights_s1", "angles_s1", "Collision_AB", "Collision_A", "Collision_B");
			
		break;
		
		#endregion
		
		#region EMERALD HILL
		
		case rm_stage_ehz0:
			
			// Use S2 physics (reverts back to default on room end)
			global.player_physics = PHYSICS.S2;
			
			setup_level(98, "EMERALD HILL", 0, snd_bgm_ehz, [spr_animal_flicky, spr_animal_ricky], room_height, -1, rm_level_select, true);
			
			bg_convert("Clouds", 0.015625, 0, 0, 0, 0);
			bg_convert("Hills_1", 0.0625, 0, 0, 0, 0);
			bg_convert("Hills_2", 0.09375, 0, 0, 0, 0);
			bg_convert_deform("Field_1", 0.09375, 0, 0, 0, 0.3515625, 1, -1, 0);
			bg_convert_deform("Field_2", 0.3515625, 0, 0, 0, 1.0, 3, -1, 0);
			
			dist_set_layer(["Clouds"], dist_get_data(EFFECTDATA.EHZ), undefined, 0, 0.125, 80, 111);
			
			pal_load(spr_palette_ehz_a, undefined);
			
			sprite_set_animation(spr_asset_ehz_00, 4);
			sprite_set_animation(spr_asset_ehz_01, 2);
			sprite_set_animation(spr_asset_ehz_02, 4);
			sprite_set_animation(spr_asset_ehz_03, 8);
			sprite_set_animation(spr_asset_ehz_04, 2);
			
			tile_load_data_binary("widths_s2", "heights_s2", "angles_s2", "Collision_AB", "Collision_A", "Collision_B");
			
		break;
		
		#endregion
		
		#region DELTA WORLD
		
		case rm_stage_dwz0:
			
			// 1040
			setup_level(99, "DELTA WORLD", ACT_SINGLE, snd_bgm_dwz, [spr_animal_flicky, spr_animal_ricky], room_height, 1600, rm_level_select, true);
			
			bg_convert("Stars_1", 0.45, 0.0725, -0.5, 0, 0);
			bg_convert("Stars_2", 0.35, 0.0725, -0.3, 0, 0);
			bg_convert("Stars_3", 0.25, 0.0725, -0.1, 0, 0);
			bg_convert("Mountains", 0.1325, 0.0725, 0, 0, 0);
			bg_convert("Forest_1", 0.15, 0.0725, 0, 0, 0);
			bg_convert("Forest_2", 0.1875, 0.0725, 0, 0, 0);
			bg_convert_deform("Lake", 0.1875, 0.0725, 0, 0, 0.65, 1, -1, 0);
			bg_convert("Bushes", 0.625, 0.0725, 0, 0, 0);
			bg_convert("Inside", 0.25, 0.25, 0, 0, 0);
			
			var _fg_layers = 
			[
				"Sprites_Front", "Pink_Front", "Red_Front", "Blue_Front", "Green_Front", 
				"Sprites_Back", "Pink_Back", "Red_Back", "Blue_Back", "Green_Back"
			];
			
			var _bg_layers =
			[
				"Lake"
			];
			
			dist_set_layer(_bg_layers, dist_get_data(EFFECTDATA.LBZ1), undefined, 0.0725, 0.25, 175, 230);
			dist_set_layer(_fg_layers, undefined, dist_get_data(EFFECTDATA.LZFG), 1.0, 0.5, 0, room_height);
			dist_set_depth("Inside", undefined, dist_get_data(EFFECTDATA.LZBG), 0.25, 0.5, 0, room_height);
			
			pal_load(spr_palette_dwz_a, spr_palette_dwz_b);
			tile_load_data(spr_collision_dwz, "Collision_AB", "Collision_A", "Collision_B");
		
		break;
		
		#endregion
	}
}