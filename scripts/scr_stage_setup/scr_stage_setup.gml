/// @self obj_rm_stage
function scr_stage_setup()
{
	switch room
	{
		#region GREEN HILL
		
		case rm_stage_ghz1:
		
			// Use S1 physics (reverts back to default on room end)
			global.player_physics = PHYSICS.S1;
			
			setup_level(96, "GREEN HILL", 0, snd_bgm_ghz, [spr_animal_flicky, spr_animal_pocky], rm_stage_ehz1, false);
			
			bg_convert("Clouds_1", 0.375, -0.03125, -1, 0, 0);
			bg_convert("Clouds_2", 0.375, -0.03125, -0.5, 0, 0);
			bg_convert("Clouds_3", 0.375, -0.03125, -0.25, 0, 0);
			bg_convert("Mountains_1", 0.375, -0.03125, 0, 0, 0);
			bg_convert("Mountains_2", 0.5, -0.03125, 0, 0, 0);
			bg_convert_deform("Lake", 0.5, -0.03125, 0, 0, 1, 1, -1, 0);
			
			pal_load(spr_palette_ghz, undefined);
			
			asset_set_animation(spr_asset_ghz_1, 16);
			asset_set_animation(spr_asset_ghz_2, 8);
			
			tile_load_data(spr_collision_s1);
			
		break;
		
		#endregion
		
		#region EMERALD HILL
		
		case rm_stage_ehz1:
			
			// Use S2 physics (reverts back to default on room end)
			global.player_physics = PHYSICS.S2;
			
			setup_level(97, "EMERALD HILL", 0, snd_bgm_ehz, [spr_animal_flicky, spr_animal_ricky], rm_level_select, true);
			
			bg_convert("Clouds", 0.015625, 0, 0, 0, 0);
			bg_convert("Hills_1", 0.0625, 0, 0, 0, 0);
			bg_convert("Hills_2", 0.09375, 0, 0, 0, 0);
			bg_convert_deform("Field_1", 0.09375, 0, 0, 0, 0.3515625, 1, -1, 0);
			bg_convert_deform("Field_2", 0.3515625, 0, 0, 0, 1, 3, -1, 0);
			
			deform_layers(["Clouds"], deform_get_data(DEFORM_DATA.EHZ), undefined, 0, 0.125, 80, 111);
			
			pal_load(spr_palette_ehz, undefined);
			
			asset_set_animation(spr_asset_ehz_1, 4);
			asset_set_animation(spr_asset_ehz_2, 2);
			asset_set_animation(spr_asset_ehz_3, 4);
			asset_set_animation(spr_asset_ehz_4, 8);
			asset_set_animation(spr_asset_ehz_5, 2);
			
			tile_load_data(spr_collision_s2);
			
		break;
		
		#endregion
		
		#region DELTA WORLD
		
		case rm_stage_dwz:
			
			setup_level(98, "DELTA WORLD", ACT_SINGLE, snd_bgm_dwz, [spr_animal_flicky, spr_animal_ricky], rm_level_select, true);
			
			bg_convert("Stars_1", 0.3275, 0.0725, -0.525, 0, 0);
			bg_convert("Stars_2", 0.2435, 0.0725, -0.325, 0, 0);
			bg_convert("Stars_3", 0.1725, 0.0725, -0.125, 0, 0);
			bg_convert("Mountains", 0.1325, 0.0725, 0, 0, 0);
			bg_convert("Forest_1", 0.15, 0.0725, 0, 0, 0);
			bg_convert("Forest_2", 0.1875, 0.0725, 0, 0, 0);
			bg_convert_deform("Lake", 0.1875, 0.0725, -0.2135, 0, 0.65, 1, -1, 0);
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
			
			deform_layers(_bg_layers, deform_get_data(DEFORM_DATA.LBZ1), undefined, 0.0725, 0.25, 180, 221);
			deform_layers(_fg_layers, undefined, deform_get_data(DEFORM_DATA.LZFG), 1, 0.5, 0, room_height);
			deform_depth("Inside", undefined, deform_get_data(DEFORM_DATA.LZBG), 0.25, 0.5, 0, room_height);
			
			pal_load(spr_palette_dwz_a, spr_palette_dwz_b);
			tile_load_data(spr_collision_dwz);
		
		break;
		
		#endregion
	}
}