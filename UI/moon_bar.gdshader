shader_type canvas_item;

uniform sampler2D gradient;
uniform float val;

void fragment() {
	vec4 pixel_color = texture(TEXTURE, UV);
	vec4 gradient_color = texture(gradient, UV);
	gradient_color *= pixel_color.a;
	COLOR = mix(pixel_color, gradient_color, clamp(val * 0.01,0.5, 1.0));
}
