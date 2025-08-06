//
// Simple passthrough fragment shader
//
const float EPSILON = 0.001;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_angle;
uniform float u_pitch;
uniform vec2 u_fov;
uniform vec2 u_scroll;

void main() {
    const vec2 tex_centre = vec2(0.5);
    vec2 uv = v_vTexcoord;
    vec2 delta = uv - tex_centre;
    
    float y_world = delta.y * u_fov.y;
    float perspective = u_pitch / (y_world + u_pitch + EPSILON);
    vec2 projected = vec2(delta.x * perspective / u_fov.x, 1.0 - perspective);
    
    float cos_a = cos(u_angle);
    float sin_a = sin(u_angle);
    vec2 rotated = vec2(projected.x * cos_a - projected.y * sin_a, projected.x * sin_a + projected.y * cos_a);
    vec2 result_uv = tex_centre + rotated;
	
	// Outside UV bounds, transparent black
    vec2 inside = step(vec2(0.0), result_uv) * step(result_uv, vec2(1.0));
	if (inside.x < 1.0 || inside.y < 1.0) {
	    gl_FragColor = vec4(0.0);
	    return;
	}
	
    result_uv.x = mod(result_uv.x + u_scroll.x, 1.0);
    result_uv.y = mod(result_uv.y + u_scroll.y, 1.0);
    
    gl_FragColor = texture2D(gm_BaseTexture, result_uv) * v_vColour;
}