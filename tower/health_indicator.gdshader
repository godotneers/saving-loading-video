shader_type canvas_item;

uniform float thickness;
uniform float progress = 1.0;
uniform float opacity = 1.0;

void fragment() {
	float progress_angle_min = progress * PI;
	float progress_angle_max = progress * - PI;
	float pixel_angle = atan( UV.x - 0.5, UV.y - 0.5);
	float pixel_distance = distance(UV, vec2(0.5));
	float outside = 0.5 -  0.003 * sin(50.0 * pixel_angle + TIME);
	
	float alpha = 1.0;
	// everything outside 0.5 is transparent
	alpha -= smoothstep(outside-0.01, outside, pixel_distance);
	// everything between 0 and 0.5 - thickness is also transparent
	alpha -= smoothstep(outside - thickness, outside - 0.01 - thickness, pixel_distance);
	// and we only want the pie 
	if (progress < 1.0) { // this is so we get a fully closed progress bar at 100%
		alpha *= 1.0 - smoothstep(0.0, 0.01, pixel_angle - progress_angle_min);
		alpha -= 1.0 - smoothstep(0.0, 0.01, pixel_angle - progress_angle_max);
	}

	alpha *= 0.2 + smoothstep(outside, outside - thickness, pixel_distance);
	alpha *= opacity;
	
	COLOR.a = alpha;
	
}
