function async_get(_event, _key)
{
	if async_load[? "event_type"] == _event 
	{
		return async_load[? _key];
	}
	
	return undefined;
}