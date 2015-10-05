module d3d.common.ext;

import d3d.common;

/// Creates an SDL_Color from a `Color` instance.
@property SDL_Color sdl_color(Color color)
{
	return SDL_Color(color.R, color.G, color.B, 255);
}
