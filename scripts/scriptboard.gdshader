shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
    float wave = sin(FRAGCOORD.y * 0.4 + (TIME * 7.0)) * 0.01;
    COLOR.rgb += wave;
}