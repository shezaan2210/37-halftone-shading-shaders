uniform vec3 uColor;
uniform vec2 uResolution;
uniform float uShadowRepeatations;
uniform vec3 uShadowColor;
uniform float uLightRepeatations;
uniform vec3 uLightColor;

varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/ambientLight.glsl
#include ../includes/directionalLight.glsl
#include ./halfTone.glsl



void main()
{
    vec3 viewDirection = normalize(vPosition - cameraPosition);
    vec3 normal = normalize(vNormal);
    vec3 color = uColor;

    // lights
    vec3 light = vec3(0.0);
    light += ambientLight(
        vec3(1.0),
        1.0
    );

    light += directionalLight(
        vec3(0.0, 1.0, 0.0), // light color
        1.0,  // light intensity
        normal, // normal
        vec3(2.0, 1.0, 0.0), // light position
        viewDirection, // view direction
        2.0 // specular power
    );


    color *= light;

    color = halftone(
    color, // input color    
    uShadowRepeatations, // repeatations
    vec3(0.0, - 1.0, 0.0), // direction
    - 0.8, //  low edge
    1.5, // high edge
    uShadowColor, // pointColor
    normal // normal
);

color = halftone(
    color,
    uLightRepeatations,
    vec3(1.0, 1.0, 0.0),
    0.5,
    1.5,
    uLightColor,
    normal
);
    

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}