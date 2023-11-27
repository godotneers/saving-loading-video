shader_type canvas_item;

uniform float health_percent = 1.0f;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 damaged_color = texture_color * vec4(1.0, 0.3, 0.3, 0.5 + abs(sin(TIME * 2.0)) * 0.5);
	
	COLOR = texture_color * (1.0 - step(health_percent, UV.x)) +
			damaged_color * (step(health_percent, UV.x));
}
