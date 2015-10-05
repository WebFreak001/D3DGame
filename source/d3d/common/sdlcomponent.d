module d3d.common.sdlcomponent;

public import derelict.sdl2.sdl;
public import derelict.sdl2.image;

import std.stdio;

/// Component for desktop windows.
/// Loads: SDL2, SDL2_image
/// Loads on use: zlib1, libjpeg-9, libpng16-16, libtiff-5, libwebp-4
final class SDLComponent
{
private:
	static bool _attached = false;

public:
	/// Loads dependencies.
	static void attach()
	{
		DerelictSDL2.load();
		DerelictSDL2Image.load();
		version (D3DDebug) writeln("Attached SDLComponent");

		SDL_Init(SDL_INIT_EVERYTHING);

		_attached = true;
	}

	/// Unloads dependencies.
	static void detach()
	{
		SDL_Quit();

		DerelictSDL2.unload();
		DerelictSDL2Image.unload();

		_attached = false;
	}

	/// Returns if this can be used.
	static @property bool attached()
	{
		return _attached;
	}
}
