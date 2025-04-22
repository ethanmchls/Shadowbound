shader_type canvas_item;

uniform vec4 shade : source_color = vec4(0.0, 0.0, 0.0, 0.75);

void fragment() {
    if (COLOR.a != 0.0) {
        COLOR = shade;
    }
}