shader_type canvas_item;

uniform vec4 modulate:source_color = vec4(1.0);

render_mode blend_add;

void fragment() {
	
	float x_mask = 0.5 * UV.y - distance(0.5, UV.x);
	float x_component = clamp(smoothstep(0., 0.05, x_mask), 0., 1.);
	float y_component = 1. - UV.y;
	
	float sine_component1 =  sin(10. * UV.x + 2.4*TIME);
	float sine_component2 = cos(-7.28 * UV.x + 1.3 * TIME);
	
	float sine_component = sine_component1 + sine_component2;
	
	
	COLOR=vec4(1.,1.,1., x_component * y_component + (0.2 * x_component * y_component * sine_component)) * modulate;
}
