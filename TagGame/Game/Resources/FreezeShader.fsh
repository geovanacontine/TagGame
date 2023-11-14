void main() {
    // find the current pixel color
    vec4 current_color = texture2D(u_texture, v_tex_coord);

    vec3 gray_values = vec3(0.2, 0.7, 1);
    gl_FragColor = vec4(gray_values * current_color.rgb, current_color.a) * current_color.a * v_color_mix.a;
}

