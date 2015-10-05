module d3d.gl3.gl3component;

import std.stdio;
public import derelict.opengl3.gl3;

/// Component for OpenGL3 powered games.
final class GL3Component
{
private:
	static bool _attached = false;

public:
	/// Loads dependencies.
	static void attach()
	{
		DerelictGL3.load();
		version (D3DDebug) writeln("Attached GL3Component");

		_attached = true;
	}

	/// Unloads dependencies.
	static void detach()
	{
		DerelictGL3.unload();

		_attached = false;
	}

	/// Returns if this can be used.
	static @property bool attached()
	{
		return _attached;
	}
}
