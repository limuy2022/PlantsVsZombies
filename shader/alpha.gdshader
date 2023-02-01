shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if(COLOR.a != 0.0) {
		COLOR.a = 0.5;	
	}
}
