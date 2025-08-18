//
// Simple passthrough fragment shader
//
varying vec2 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_pos;
uniform vec2 u_texel_size;
uniform float u_camera_x;
uniform float u_offset_x;
uniform float u_sprite_h;
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
	
	if (u_increment < 0.0){
		offsetFactor = 1.0 - offsetFactor;
	}
	
	float scroll = u_camera_x * distanceFactor + u_offset_x * offsetFactor * -sign(u_increment);
	scroll *= sign(u_yscale);
	
	// This requires the texture to be the only one on its page!
    uv.x = fract(uv.x + scroll / u_texel_size.x);
	uv.x = (u_yscale < 0.0) ? 1.0 - uv.x : uv.x;
	
    gl_FragColor = texture2D(gm_BaseTexture, uv) * v_vColour;
}