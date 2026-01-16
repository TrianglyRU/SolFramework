/// @self obj_rm_stage
function scr_stage_setup()
{
	switch room
	{
		case rm_stage_ghz1:
		
			// Use S1 physics (reverts back to default on room end)
			global.player_physics = PHYSICS.S1;
			
			setup_level(96, "RETRO LEVELS", 0, snd_bgm_ghz, [spr_animal_flicky, spr_animal_pocky], rm_stage_ehz1, false);
			
			bg_convert("Clouds_1", 0.375, -0.03125, -1, 0, 0);
			bg_convert("Clouds_2", 0.375, -0.03125, -0.5, 0, 0);
			bg_convert("Clouds_3", 0.375, -0.03125, -0.25, 0, 0);
			bg_convert("Mountains_1", 0.375, -0.03125, 0, 0, 0);
			bg_convert("Mountains_2", 0.5, -0.03125, 0, 0, 0);
			bg_convert_scaled("Lake", 0.5, -0.03125, 0, 0, 1, 1, -1, 0);
			
			pal_load(spr_palette_ghz, undefined);
			pal_set_rotation([30, 31, 32, 33], 6, 1, 4);
			
			asset_set_animation(spr_asset_ghz_1, 16);
			asset_set_animation(spr_asset_ghz_2, 8);
			
			tile_load_data(spr_collision_s1);
			
		break;
		
		case rm_stage_ehz1:
			
			// Use S2 physics (reverts back to default on room end)
			global.player_physics = PHYSICS.S2;
			
			setup_level(97, "RETRO LEVELS", 1, snd_bgm_ehz, [spr_animal_flicky, spr_animal_ricky], rm_stage_ssz1, false);
			
			bg_convert("Clouds", 0.015625, 0, 0, 0, 0);
			bg_convert("Hills_1", 0.0625, 0, 0, 0, 0);
			bg_convert("Hills_2", 0.09375, 0, 0, 0, 0);
			bg_convert_scaled("Field_1", 0.09375, 0, 0, 0, 0.3515625, 1, -1, 0);
			bg_convert_scaled("Field_2", 0.3515625, 0, 0, 0, 1, 3, -1, 0);
			
			var _bg_layers =
			[
				"Clouds"
			];
			
			deform_layers(_bg_layers, deform_get_data(DEFORM_DATA.EHZ), undefined, 0, 0.125, 80, 111);
			
			pal_load(spr_palette_ehz, undefined);
			pal_set_rotation([30, 31, 32, 33], 8, 1, 4);
			
			asset_set_animation(spr_asset_ehz_1, 4);
			asset_set_animation(spr_asset_ehz_2, 2);
			asset_set_animation(spr_asset_ehz_3, 4);
			asset_set_animation(spr_asset_ehz_4, 8);
			asset_set_animation(spr_asset_ehz_5, 2);
			
			tile_load_data(spr_collision_s2);
			
		break;
		
		case rm_stage_ssz1:
			
			texture_prefetch("texgroup_ssz_graphics");
			
			setup_level(98, "RETRO LEVELS", 2, snd_bgm_ssz, [spr_animal_cucky, spr_animal_picky], rm_level_select, true);
			
			var _factor_y = (448 - global.init_resolution_h) / (2048 - global.init_resolution_h);
			
			bg_convert("Sky", 0.09375, _factor_y * 0.75, -0.25, 0, 0);
			bg_convert("Mountains", 0.09375, _factor_y, 0, 0, 0);
			bg_convert("Waterfalls", 0.1875, _factor_y, 0, 0, 0);
			bg_convert_scaled("Lake", 0.1875, _factor_y, 0, 0, 0.921875, 1, -1, 0);
			
			pal_load(spr_palette_ssz, undefined);
			pal_set_rotation([30, 31, 32, 33], 6, 1, 4);
			
			tile_load_data(spr_collision_ssz);
		
		break;
		
		case rm_stage_dwz:
			
			setup_level(99, "DELTAWORLD", ACT_SINGLE, snd_bgm_dwz, [spr_animal_rocky, spr_animal_pecky], rm_level_select, false);
			
			bg_convert("Background", 0.25, 0.25, 0, 0, 0);
			
			var _fg_layers = 
			[
				"Sprites_Front", "Pink_Front", "Red_Front", "Blue_Front", "Green_Front", 
				"Sprites_Back", "Pink_Back", "Red_Back", "Blue_Back", "Green_Back"
			];
			
			var _bg_layers =
			[
				"Background"
			];
			
			deform_layers(_fg_layers, undefined, deform_get_data(DEFORM_DATA.LZFG), 1, 0.5, 0, room_height);
			deform_layers(_bg_layers, undefined, deform_get_data(DEFORM_DATA.LZBG), 0.25, 0.5, 0, room_height);
			
			pal_load(spr_palette_dwz_a, spr_palette_dwz_b);
			pal_set_rotation([30, 31, 32, 33], 6, 1, 4);
			pal_set_rotation([34], 20, 1, 8);
			
			tile_load_data(spr_collision_dwz);
		
		break;
	}
}