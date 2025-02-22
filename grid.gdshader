shader_type canvas_item;


//uniform vec2 u_resolution;
uniform vec2 u_gridSize;
uniform vec4 u_lineColor : source_color;
uniform float u_lineWidth;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 u_resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE);

    // Scale UV by the grid size
    vec2 gridUV = uv * u_resolution / u_gridSize;

    // Compute the distance to the nearest grid line
    vec2 gridLine = abs(fract(gridUV) - 0.5);

    // Get the minimum distance to a line in either axis
    float line = min(gridLine.x, gridLine.y);

    // Smoothstep to create a soft grid line effect
    float lineMask = smoothstep(u_lineWidth, 0.0, line);

    // Blend grid color with the background
    COLOR = mix(u_lineColor, vec4(0.0), 1.0 - lineMask);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
