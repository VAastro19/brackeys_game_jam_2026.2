shader_type canvas_item;

uniform float saturation = 0.7;

varying vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    COLOR.rgb = mix(vec3(dot(tex_color.rgb, vec3(0.299, 0.587, 0.114))), tex_color.rgb, saturation);
	COLOR.a = tex_color.a;
	COLOR = modulate * COLOR;
}