enum FORCE_SPIN
{
	UNIVERSAL,
	START_ONLY,
	END_ONLY
}

// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.PAUSE);

depth = RENDER_DEPTH_PRIORITY;