shader_type canvas_item;
render_mode unshaded;

#define max_colors 4

uniform float border_size = 1.0;
uniform vec2 scale = vec2(10, 10);
uniform float rot_speed = 1.0;
uniform int color_count : hint_range(0, max_colors) = 0;
uniform vec4 colors[max_colors] : source_color;

void vertex() {
}

bool is_in_border(vec2 uv) {
	vec2 scaled_pos = scale * (uv - vec2(0.5));
	return abs(scaled_pos.x) > scale.x * 0.5 - border_size ||
		abs(scaled_pos.y) > scale.y * 0.5 - border_size;
}

float fmod_one(float value) {
	return value - float(int(value));
}

vec4 calc_color(vec2 uv) {
	vec2 rot_pos = uv - vec2(0.5);
	float angle = atan(rot_pos.y, rot_pos.x);
	float zero_one_angle = angle * 0.5 / PI + 0.5;
	float amount = fmod_one(zero_one_angle + TIME * rot_speed);
	int idx = int(amount * float(color_count));
	return colors[idx];
}

void fragment() {
	if (color_count == 0 || !is_in_border(UV))
		COLOR.a = 0.0;
	else if (color_count == 1)
		COLOR = colors[0];
	else
		COLOR = calc_color(UV);
}
