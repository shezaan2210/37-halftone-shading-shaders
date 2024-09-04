vec3 halftone(
    vec3 color,
    float repeatations,
    vec3 direction,
    float low,
    float high,
    vec3 pointColor,
    vec3 normal
){
    float intensity = dot(normal, direction);
    intensity = smoothstep(low, high, intensity);

    vec2 uv = gl_FragCoord.xy / uResolution.y;
    uv *= repeatations;
    uv = mod(uv, 1.0);

    float point = distance(uv, vec2(0.5));
    point = 1.0 - step(0.5 * intensity, point);

    return mix(color, pointColor, point);
}