//
// Simple passthrough fragment shader
//
#define DATA_LIMIT 256

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_indices[DATA_LIMIT];
uniform float u_bound;
uniform sampler2D u_texture_a;
uniform vec2 u_texel_a;
uniform vec3 u_uv_a;
uniform sampler2D u_texture_b;
uniform vec2 u_texel_b;
uniform vec3 u_uv_b;

vec4 getSwappedColour(vec4 target, sampler2D texture, vec2 texel, vec3 uv) {
    float start = uv.y;
    float end = min(uv.z, float(DATA_LIMIT));
    float x = uv.x;
	
    for (float i = start; i < end; i += texel.y) {
        vec2 pos = vec2(x, i);
        vec4 col = texture2D(texture, pos);
        
        if (col == target) {
            int index = int((i - start) / texel.y);
            float offset = texel.x * floor(u_indices[index]);
            return texture2D(texture, vec2(x + offset, i));
        }
    }

    return target;
}

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 swapped = (u_bound > gl_FragCoord.y) ? getSwappedColour(base, u_texture_a, u_texel_a, u_uv_a) 
											  : getSwappedColour(base, u_texture_b, u_texel_b, u_uv_b);
    gl_FragColor = swapped * v_vColour;
}