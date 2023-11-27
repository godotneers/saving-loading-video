shader_type canvas_item;

uniform vec4 modulate:source_color = vec4(1.0); 
uniform float time_scale = 1.0;

void fragment() {
		float scaleY = (0.4 + 0.2 * sin(11. * (0.2 + TIME * time_scale))) * 
			(1.0 - smoothstep(0., 0.7, UV.x));
		float scaleX = (0.5 + 0.2 * sin(5. * TIME * time_scale)) *
			(1.0 - smoothstep(0.2, 0.85, UV.x));
		COLOR = texture(TEXTURE, vec2(UV.x + (UV.x - 0.5) * scaleX,   UV.y + (UV.y - 0.5) * scaleY)) * modulate;
}
