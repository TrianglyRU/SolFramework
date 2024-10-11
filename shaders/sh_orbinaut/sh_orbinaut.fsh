// Simple passthrough fragment shader

precision highp float;
precision highp int;

#define PALETTE_LIMIT 256					// This should match PALETTE_TOTAL_SLOT_COUNT
#define PALETTE_GLOBAL_SIZE 64				// This should match PALETTE_GLOBAL_SLOT_COUNT
#define PALETTE_LOCAL_SIZE 192				// PALETTE_LIMIT - PALETTE_LOCAL_SIZE

const float LIMIT1 = 255.0;
const float LIMIT2 = 510.0;					// LIMIT1 * 2.0
const float LIMIT3 = 765.0;					// LIMIT1 * 3.0. This should match FADE_TIMER_MAX

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform bool u_fade_active;
uniform int u_fade_type;
uniform float u_fade_step;

uniform float u_pal_indexes[PALETTE_LIMIT];
uniform float u_pal_bound;
uniform bool u_pal_active;

uniform sampler2D u_pal_tex_a_global;
uniform vec2 u_pal_texel_size_a_global;
uniform vec3 u_pal_uv_a_global;

uniform sampler2D u_pal_tex_a_local;
uniform vec2 u_pal_texel_size_a_local;
uniform vec3 u_pal_uv_a_local;

uniform sampler2D u_pal_tex_b_global;
uniform vec2 u_pal_texel_size_b_global;
uniform vec3 u_pal_uv_b_global;

uniform sampler2D u_pal_tex_b_local;
uniform vec2 u_pal_texel_size_b_local;
uniform vec3 u_pal_uv_b_local;

uniform bool u_bg_active;
uniform vec4 u_bg_offset;
uniform vec2 u_bg_pos;
uniform vec2 u_bg_size;
uniform vec2 u_bg_map_size;
uniform float u_bg_scaling;
uniform float u_bg_incline_height;
uniform float u_bg_incline_step;

vec3 getFadedColour(vec3 colour) {
	
    if (u_fade_type == 0) {
        return min(colour - LIMIT3 + u_fade_step + vec3(0.0, colour.r, colour.r + colour.g), colour);
    } else if (u_fade_type == 1) {
        return min(u_fade_step - vec3(colour.b + colour.g, colour.b, 0.0), colour);
    } else if (u_fade_type == 2) {
        return min(colour, u_fade_step);
    } else if (u_fade_type == 3) {
        return max(colour - max(LIMIT1 - u_fade_step, 0.0), 0.0);
    } else if (u_fade_type == 4) {
        return max(vec3(LIMIT2 - colour.b - colour.g, LIMIT1 - colour.b, 0.0) - u_fade_step + LIMIT1, colour);
    } else if (u_fade_type == 5) {
        return max(colour + LIMIT3 - u_fade_step - vec3(0.0, LIMIT1 - colour.r, LIMIT2 - colour.r - colour.g), colour);
    } else if (u_fade_type == 6) {
        return max(colour, LIMIT1 - u_fade_step);
    } else if (u_fade_type == 7) {
        return min(colour + max(LIMIT1 - u_fade_step, 0.0), LIMIT1);
    }
    
    return colour;
}

vec2 getParallaxedCoord() {
	
    vec2 position = v_vPosition - u_bg_pos;
    vec2 offset = u_bg_offset.xy;
    float inclineFactor = u_bg_incline_height != 0.0 ? floor((position.y / u_bg_scaling - u_bg_size.y) / u_bg_incline_height + 1.0) * u_bg_incline_step + 1.0 : 1.0;

    offset.x *= inclineFactor;
	
    vec2 modPosition = mod(floor(offset) + position - u_bg_offset.zw, u_bg_size);
    offset = mod(modPosition + u_bg_size, u_bg_size) - position;
	
    offset.y = u_bg_scaling != 0.0 ? 0.0 : offset.y;
	
    return offset / u_bg_map_size;
}

vec4 getSwappedColourA(vec4 target) {
	
	vec4 newTarget = target;
	float limitGlobal = min(u_pal_uv_a_global.z, float(PALETTE_GLOBAL_SIZE));
	float limitLocal = min(u_pal_uv_a_local.z, float(PALETTE_LOCAL_SIZE));
    float texelSizeGlobalY = u_pal_texel_size_a_global.y;
    float texelSizeGlobalX = u_pal_texel_size_a_global.x;
    float uvAGlobalX = u_pal_uv_a_global.x;

    for (float i = u_pal_uv_a_global.y; i < limitGlobal; i += texelSizeGlobalY) {
        vec2 colourPos = vec2(uvAGlobalX, i);
        vec4 texColour = texture2D(u_pal_tex_a_global, colourPos);

        if (texColour == target) {
            float replacementIndex = u_pal_indexes[int((i - u_pal_uv_a_global.y) / texelSizeGlobalY)];
            colourPos.x += texelSizeGlobalX * floor(replacementIndex + 1.0);
            
            return mix(texture2D(u_pal_tex_a_global, vec2(colourPos.x - texelSizeGlobalX, colourPos.y)), texture2D(u_pal_tex_a_global, colourPos), fract(replacementIndex));
        }
    }

	float texelSizeLocalY = u_pal_texel_size_a_local.y;
    float texelSizeLocalX = u_pal_texel_size_a_local.x;
    float uvALocalX = u_pal_uv_a_local.x;

	for (float i = u_pal_uv_a_local.y; i < limitLocal; i += texelSizeLocalY) {
        vec2 colourPos = vec2(uvALocalX, i);
		vec4 texColour = texture2D(u_pal_tex_a_local, colourPos);

        if (texColour == target) {
            float replacementIndex = u_pal_indexes[int((i - u_pal_uv_a_local.y) / texelSizeLocalY + float(PALETTE_GLOBAL_SIZE))];
            colourPos.x += texelSizeLocalX * floor(replacementIndex + 1.0);
            
            return mix(texture2D(u_pal_tex_a_local, vec2(colourPos.x - texelSizeLocalX, colourPos.y)), texture2D(u_pal_tex_a_local, colourPos), fract(replacementIndex));
        }
    }
	
    return newTarget;
}

vec4 getSwappedColourB(vec4 target) {
	
	vec4 newTarget = target;
	float limitGlobal = min(u_pal_uv_b_global.z, float(PALETTE_GLOBAL_SIZE));
	float limitLocal = min(u_pal_uv_b_local.z, float(PALETTE_LOCAL_SIZE));
    float texelSizeGlobalY = u_pal_texel_size_b_global.y;
    float texelSizeGlobalX = u_pal_texel_size_b_global.x;
    float uvBGlobalX = u_pal_uv_b_global.x;

    for (float i = u_pal_uv_b_global.y; i < limitGlobal; i += texelSizeGlobalY) {
        vec2 colourPos = vec2(uvBGlobalX, i);
        vec4 texColour = texture2D(u_pal_tex_b_global, colourPos);

        if (texColour == target) {
            float replacementIndex = u_pal_indexes[int((i - u_pal_uv_b_global.y) / texelSizeGlobalY)];
            colourPos.x += texelSizeGlobalX * floor(replacementIndex + 1.0);
            
            return mix(texture2D(u_pal_tex_b_global, vec2(colourPos.x - texelSizeGlobalX, colourPos.y)), texture2D(u_pal_tex_b_global, colourPos), fract(replacementIndex));
        }
    }

	float texelSizeLocalY = u_pal_texel_size_b_local.y;
    float texelSizeLocalX = u_pal_texel_size_b_local.x;
    float uvBLocalX = u_pal_uv_b_local.x;
	
	for (float i = u_pal_uv_b_local.y; i < limitLocal; i += texelSizeLocalY) {
        vec2 colourPos = vec2(uvBLocalX, i);
		vec4 texColour = texture2D(u_pal_tex_b_local, colourPos);

        if (texColour == target) {
            float replacementIndex = u_pal_indexes[int((i - u_pal_uv_b_local.y) / texelSizeLocalY + float(PALETTE_GLOBAL_SIZE))];
            colourPos.x += texelSizeLocalX * floor(replacementIndex + 1.0);
            
            return mix(texture2D(u_pal_tex_b_local, vec2(colourPos.x - texelSizeLocalX, colourPos.y)), texture2D(u_pal_tex_b_local, colourPos), fract(replacementIndex));
        }
    }

    return newTarget;
}

void main() {
	
    vec4 outColour = texture2D(gm_BaseTexture, u_bg_active ? v_vTexcoord + getParallaxedCoord() : v_vTexcoord);
	
    if (u_pal_active) {
        outColour = (u_pal_bound > gl_FragCoord.y ? getSwappedColourA(outColour) : getSwappedColourB(outColour)) * v_vColour;
    }
	
    gl_FragColor = u_fade_type < 0 || !u_fade_active ? outColour : vec4(getFadedColour(outColour.rgb * 255.0) / 255.0, outColour.a);
}