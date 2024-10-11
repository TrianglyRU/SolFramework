//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

#define DATA_LIMIT 256

precision mediump float;

uniform float g_Width;
uniform float g_Offset;
uniform float g_DataSizeA;
uniform float g_DataSizeB;
uniform float g_BoundUpper;    
uniform float g_BoundMiddle;
uniform float g_BoundLower;

uniform float g_DataA[DATA_LIMIT];
uniform float g_DataB[DATA_LIMIT];

void main() {
    vec2 outCoord = v_vTexcoord;
    float screenY = gl_FragCoord.y;
    
    if (screenY >= g_BoundUpper && screenY <= g_BoundLower) {
        if (screenY < g_BoundMiddle) {
            outCoord.x -= g_DataA[int(mod(g_Offset + screenY, g_DataSizeA))] / g_Width;
        } else {
            outCoord.x -= g_DataB[int(mod(g_Offset + screenY, g_DataSizeB))] / g_Width;
        }
    }

    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, outCoord);
}