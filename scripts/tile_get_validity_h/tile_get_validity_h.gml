/// @self
/// @description Evaluates the validity of a tile along a horizontal axis based on the specified direction and tile behaviour.
/// @param {Real} _tiledata The tile data.
/// @param {Enum.DIRECTION} _dir The direction to check the tile's validity.
/// @param {Enum.TILEBEHAVIOUR} _behaviour The behaviour of the tile to consider when evaluating validity.
/// @returns {Bool}
function tile_get_validity_h(_tiledata, _dir, _behaviour)
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
				case TILEBEHAVIOUR.ROTATE_180:
					return false;

				case TILEBEHAVIOUR.ROTATE_90:
					return _dir == DIRECTION.POSITIVE;

				case TILEBEHAVIOUR.ROTATE_270:
					return _dir != DIRECTION.POSITIVE;
			}
		
		// LBR Solid & Invalid
		default:
		
			switch (_behaviour)
			{		
				case TILEBEHAVIOUR.DEFAULT:
				case TILEBEHAVIOUR.ROTATE_180:
					return true;

				case TILEBEHAVIOUR.ROTATE_90:
					return _dir != DIRECTION.POSITIVE;

				case TILEBEHAVIOUR.ROTATE_270:
					return _dir == DIRECTION.POSITIVE;
			}
	}
}
