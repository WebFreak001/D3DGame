import std.stdio;

import d3d.core;
import d3d.common;
import d3d.desktop;

class GameWindow : SDLWindow
{
	RenderContext context;

	override protected void onCreate()
	{
		context = RenderContext(null, null, renderer);
	}

	override protected void onDraw()
	{
		renderer.clearBuffer(RenderBuffer.colorDepth);
		draw3D(context);
	}

	override protected bool onUpdate(float delta)
	{
		update(delta);
		return true;
	}
}

void main()
{
	with (createContext!(SDLComponent, SDLDesktopComponent))
	{
		view = new GameWindow();
		while (update())
		{
			draw();
			endUpdate();
		}
	}
}
