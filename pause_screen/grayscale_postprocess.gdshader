shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
   // read in the current pixel
   vec4 input = texture(screen_texture, SCREEN_UV);    
   // convert color to grayscale using CIE 1931 linear luminance
   // https://en.wikipedia.org/wiki/Grayscale
   float col = (input.r * 0.2126 + input.g * 0.7152 + input.b * 0.0722); 
   // dim color a bit down
   col *= 0.7;
   // and write new pixel
   COLOR = vec4(col, col, col, 1);
}