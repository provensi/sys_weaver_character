shader_type spatial;

uniform vec3 main_color : source_color = vec3(1.0, 1.0, 1.0);
uniform float diffuse_edge_1 : hint_range(0.0, 1.0) = 0.01;
uniform float diffuse_edge_2 : hint_range(0.0, 1.0) = 0.1;
uniform float specular_power : hint_range(0.0, 100.0) = 40.0;
uniform vec3 rim_color : source_color = vec3(1.0, 1.0, 1.0);
uniform float rim_power : hint_range(0.0, 100.0) = 4.0;
uniform float rim_threshold : hint_range(0.0, 1.0) = 0.02;

void fragment() {
    ALBEDO = main_color;
}

void light() {
    float nDotL = clamp(dot(NORMAL, LIGHT), 0.0, 1.0);
    nDotL = smoothstep(diffuse_edge_1, diffuse_edge_2, nDotL);
    vec3 diffuse_result = vec3(nDotL);
    vec3 addedCam = normalize(VIEW + LIGHT);
    float vDotL = clamp(dot(NORMAL, addedCam), 0.0, 1.0);
    vDotL = pow(vDotL, specular_power);
    float rimLight = clamp(dot(NORMAL, VIEW), 0.0, 1.0);
    rimLight = pow(1.0 - rimLight, rim_power) * nDotL;
    rimLight = smoothstep(0.0, rim_threshold, rimLight);
    DIFFUSE_LIGHT += diffuse_result + rimLight * rim_color;
    SPECULAR_LIGHT += vDotL;
}
