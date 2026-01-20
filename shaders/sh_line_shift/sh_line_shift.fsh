//
// Simple passthrough fragment shader
//
varying vec2 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_pos;
uniform vec2 u_size;
uniform float u_camera_x;
uniform float u_offset_x;
uniform float u_line_h;
uniform float u_lines_total;
uniform float u_yscale;
uniform float u_increment;

void main() {
	vec2 uv = v_vTexcoord;
    vec2 pos = v_vPosition - u_pos;
	
	float size = u_line_h * abs(u_yscale);
	float line = u_yscale < 0.0 ? ceil(pos.y / size) : floor(pos.y / size);
	
	float distanceFactor = line * u_increment;
	float offsetFactor = line / u_lines_total;
	
	if (u_increment < 0.0) {
		offsetFactor = 1.0 - offsetFactor;
	}
	
	float shift = u_camera_x * distanceFactor;					// base shift
	shift += u_offset_x * offsetFactor * -sign(u_increment);	// + offset
	shift *= sign(u_yscale);									// + yscale
	
	// This requires the sprite to be the only one on its texture page
	// and to have a width that is a power of two
    uv.x = fract(uv.x + (shift / u_size.x));
	
    gl_FragColor = texture2D(gm_BaseTexture, uv) * v_vColour;
}