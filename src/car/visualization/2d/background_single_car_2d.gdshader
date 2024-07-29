shader_type canvas_item;
uniform vec2 world_pos = vec2(0,0);
uniform sampler2D base_texture;
uniform float n_repeats = 2;
uniform float base_texture_size=1;
 

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 scaled_uv = vec2(mod(UV.x*n_repeats+world_pos.x/base_texture_size,1),mod(UV.y*n_repeats+world_pos.y/base_texture_size,1));
	COLOR = texture(base_texture,scaled_uv);
	//COLOR = vec4(UV,0.0,1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
