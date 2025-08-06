//
// Simple passthrough fragment shader
//
varying vec2 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_pos;
uniform vec2 u_texel_size;
uniform float u_increment;
uniform float u_line_h;
uniform float u_yscale;
uniform float u_camera_x;

void main() {
	vec2 uv = v_vTexcoord;
    vec2 pos = v_vPosition - u_pos;
	
    float index = floor(pos.y / u_line_h);
    float offset = u_camera_x * index * u_increment;
	
	// This requires the texture to be the only one on its page!
    uv.x = fract(uv.x + offset / u_texel_size.x) * sign(u_yscale);
	
    gl_FragColor = texture2D(gm_BaseTexture, uv) * v_vColour;
}