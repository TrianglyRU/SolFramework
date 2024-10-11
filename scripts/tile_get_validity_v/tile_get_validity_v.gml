/// @self
/// @description Evaluates the validity of a tile along a vertical axis based on the specified direction and tile behaviour.
/// @param {Real} _tiledata The tile data.
/// @param {Enum.DIRECTION|Real} _dir The direction to check the tile's validity.
/// @param {Enum.TILEBEHAVIOUR|Real} _behaviour The behaviour of the tile to consider when evaluating validity.
/// @returns {Bool}
function tile_get_validity_v(_tiledata, _dir, _behaviour)
{
	switch (floor(tile_get_index(_tiledata) / TILE_COUNT))
	{
		// All Solid
		case 0:
			return true;
		
		// Top Solid
		case 1:
		
			switch (_behaviour)
			{
				case TILEBEHAVIOUR.DEFAULT:
					return _dir == DIRECTION.POSITIVE;
					
				case TILEBEHAVIOUR.ROTATE_180:
					return _dir != DIRECTION.POSITIVE;
					
				case TILEBEHAVIOUR.ROTATE_270: 
				case TILEBEHAVIOUR.ROTATE_90:
					return false;
			}
			
		// LBR Solid & Invalid
		default:
		
			switch (_behaviour)
			{				
				case TILEBEHAVIOUR.DEFAULT:
					return _dir != DIRECTION.POSITIVE;
					
				case TILEBEHAVIOUR.ROTATE_180:
					return _dir == DIRECTION.POSITIVE;
					
				case TILEBEHAVIOUR.ROTATE_270: 
				case TILEBEHAVIOUR.ROTATE_90:
					return true;
			}
	}
}
