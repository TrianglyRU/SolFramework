function async_trigger(_event, _key, _value)
{
	var _map = ds_map_create();
	
	_map[? "event_type"] = _event;
	_map[? _key] = _value;
	
	event_perform_async(ev_async_system_event, _map);
}