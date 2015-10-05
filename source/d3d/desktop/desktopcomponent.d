module d3d.desktop.desktopcomponent;

public import derelict.sdl2.sdl;
import d3d.core;
import d3d.common.sdlcomponent : SDLComponent;

/// Component for desktop windows. Will use SDL from d3d.common if possible.
/// Loads: SDL2
@softdepend("d3d.common.sdlcomponent.SDLComponent")
final class SDLDesktopComponent
{
private:
	static bool _attached = false;

public:
	/// Loads DerelictSDL2 if not loaded by SDLComponent.
	static void attach()
	{
		_attached = true;
		if (!SDLComponent.attached)
		{
			DerelictSDL2.load();
			SDL_Init(SDL_INIT_EVERYTHING);
			version (D3DDebug) writeln("Attached SDLDesktopComponent");
		}
	}

	/// Unloads DerelictSDL2 if not loaded by SDLComponent.
	static void detach()
	{
		_attached = false;
		if (!SDLComponent.attached)
		{
			SDL_Quit();
			DerelictSDL2.unload();
		}
	}

	/// Returns if this can be used.
	static @property bool attached()
	{
		return _attached || SDLComponent.attached;
	}
}
