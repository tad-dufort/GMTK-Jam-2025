shader_type canvas_item;

void fragnent() {
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV) * vec4(1.0, 1.0, 1.0, COLOR.a);
}