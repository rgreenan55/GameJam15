shader_type canvas_item;

uniform sampler2D noise_texture: repeat_enable, filter_nearest;
uniform float density: hint_range(0.0, 1.0);
uniform vec2 speed;

// Called for every pixel the material is visible on.
void fragment() {
	// Make fog slowly move
	vec2 uv = UV + speed * TIME;
	// Sample Noise Texture
	float noise = texture(noise_texture, uv).r;
	// Convert from (0.0 , 1.0) range to (-1.0, 1.0) range, and clamp between 0.0 and 1.0.
	float fog = clamp(noise * 2.0 - 1.0, 0.0, 1);
	// Apply Fog Effect
	COLOR.a *= fog * density;
}
