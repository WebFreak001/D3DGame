module d3d.desktop.sdlwindow;

import d3d.desktop;
import d3d.core;
import d3d.common;

import std.string;

/// Window creation flags.
enum WindowFlags : uint
{
	None,
	/// Fullscreen window with custom resolution.
	Fullscreen = SDL_WINDOW_FULLSCREEN,
	/// Fullscreen window without automatic resolution.
	FullscreenAuto = SDL_WINDOW_FULLSCREEN_DESKTOP,
	/// Directly show the window without calling `show();`
	Shown = SDL_WINDOW_SHOWN,
	/// Window is hidden by default and needs to be shown by `show();`
	Hidden = SDL_WINDOW_HIDDEN,
	/// Window has no border or title bar.
	Borderless = SDL_WINDOW_BORDERLESS,
	/// Window is resizable.
	Resizable = SDL_WINDOW_RESIZABLE,
	/// Window is initially started in minimized mode.
	Minimized = SDL_WINDOW_MINIMIZED,
	/// Window is initially started in maximized mode.
	Maximized = SDL_WINDOW_MAXIMIZED,
	/// Window directly gains input and mouse focus on startup.
	Focused = SDL_WINDOW_INPUT_FOCUS | SDL_WINDOW_MOUSE_FOCUS,
	/// Window allows high DPI monitors.
	HighDPI = SDL_WINDOW_ALLOW_HIGHDPI,
	/// Combination of `Shown | Focused`
	Default = Shown | Focused,
}

abstract class SDLWindow : IView
{
private:
	SDL_Window* _handle;
	int _id;
	u32vec2 _size;
	string _name;
	WindowFlags _flags;

public:
	@property SDL_Window* handle()
	{
		return _handle;
	}

	@property int id()
	{
		return _id;
	}

	@property bool valid()
	{
		return _handle !is null;
	}

	Event!u32vec2 onResized = new Event!u32vec2;
	Event!u32vec2 onMove = new Event!u32vec2;
	Trigger onShow = new Trigger;
	Trigger onHide = new Trigger;
	Trigger onExpose = new Trigger;
	Trigger onMinimize = new Trigger;
	Trigger onMaximize = new Trigger;
	Trigger onRestore = new Trigger;
	Trigger onEnter = new Trigger;
	Trigger onLeave = new Trigger;
	Trigger onFocusGain = new Trigger;
	Trigger onFocusLost = new Trigger;
	Trigger onClose = new Trigger;

	this(string title, u32vec2 size = u32vec2(320, 240), WindowFlags flags = WindowFlags.Default)
	{
		_name = title;
		_size = size;
		_flags = flags;
	}

	this(string title, uint width, uint height, WindowFlags flags = WindowFlags.Default)
	{
		this(title, u32vec2(width, height), flags);
	}

	this(WindowFlags flags = WindowFlags.Default)
	{
		this("", 0, 0, flags);
	}

	~this()
	{
		SDL_DestroyWindow(_handle);
		_handle = null;
	}

	override void create()
	{
		if (_size.x == 0 && _size.y == 0)
		{
			SDL_DisplayMode current;

			SDL_GetCurrentDisplayMode(0, &current);

			_size.x = current.w;
			_size.y = current.h;

			_flags |= SDL_WINDOW_BORDERLESS;
		}

		_handle = SDL_CreateWindow(_name.toStringz(), SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, cast(int) _size.x, cast(int) _size.y, _flags);
		assert(valid, fromStringz(SDL_GetError()));
		_id = SDL_GetWindowID(_handle);
	}

	void handleEvent(in SDL_Event event)
	{
		if (valid)
		{
			if (event.type == SDL_WINDOWEVENT && event.window.windowID == id)
			{
				switch (event.window.event)
				{
				case SDL_WINDOWEVENT_SHOWN:
					onShow(this);
					break;
				case SDL_WINDOWEVENT_HIDDEN:
					onHide(this);
					break;
				case SDL_WINDOWEVENT_EXPOSED:
					onExpose(this);
					break;
				case SDL_WINDOWEVENT_MOVED:
					onMove(this, u32vec2(event.window.data1, event.window.data2));
					break;
				case SDL_WINDOWEVENT_RESIZED:
					size = u32vec2(event.window.data1, event.window.data2);
					onResized(this, size);
					break;
				case SDL_WINDOWEVENT_MINIMIZED:
					onMinimize(this);
					break;
				case SDL_WINDOWEVENT_MAXIMIZED:
					onMaximize(this);
					break;
				case SDL_WINDOWEVENT_RESTORED:
					onRestore(this);
					break;
				case SDL_WINDOWEVENT_ENTER:
					onEnter(this);
					break;
				case SDL_WINDOWEVENT_LEAVE:
					onLeave(this);
					break;
				case SDL_WINDOWEVENT_FOCUS_GAINED:
					onFocusGain(this);
					break;
				case SDL_WINDOWEVENT_FOCUS_LOST:
					onFocusLost(this);
					break;
				case SDL_WINDOWEVENT_CLOSE:
					onClose(this);
					SDL_DestroyWindow(_handle);
					_handle = null;
					break;
				default: break;
				}
			}
		}
	}

	@property void title(string title)
	{
		SDL_SetWindowTitle(_handle, title.toStringz());
	}

	@property string title()
	{
		return cast(string) SDL_GetWindowTitle(_handle).fromStringz();
	}

	@property void size(u32vec2 size)
	{
		SDL_SetWindowSize(_handle, cast(int) size.x, cast(int) size.y);
	}

	@property u32vec2 size()
	{
		int x, y;
		SDL_GetWindowSize(_handle, &x, &y);
		return u32vec2(cast(uint) x, cast(uint) y);
	}

	@property void maxSize(u32vec2 size)
	{
		SDL_SetWindowMaximumSize(_handle, cast(int) size.x, cast(int) size.y);
	}

	@property u32vec2 maxSize()
	{
		int x, y;
		SDL_GetWindowMaximumSize(_handle, &x, &y);
		return u32vec2(cast(uint) x, cast(uint) y);
	}

	@property void minSize(u32vec2 size)
	{
		SDL_SetWindowMinimumSize(_handle, cast(int) size.x, cast(int) size.y);
	}

	@property u32vec2 minSize()
	{
		int x, y;
		SDL_GetWindowMinimumSize(_handle, &x, &y);
		return u32vec2(cast(uint) x, cast(uint) y);
	}

	@property void position(i32vec2 pos)
	{
		SDL_SetWindowPosition(_handle, pos.x, pos.y);
	}

	@property i32vec2 position()
	{
		int x, y;
		SDL_GetWindowPosition(_handle, &x, &y);
		return i32vec2(x, y);
	}

	void show()
	{
		SDL_ShowWindow(_handle);
	}

	void hide()
	{
		SDL_HideWindow(_handle);
	}

	void minimized()
	{
		SDL_MinimizeWindow(_handle);
	}

	void maximize()
	{
		SDL_MaximizeWindow(_handle);
	}

	void restore()
	{
		SDL_RestoreWindow(_handle);
	}

	void focus()
	{
		SDL_RaiseWindow(_handle);
	}

	void setIcon(Surface icon)
	{
		SDL_SetWindowIcon(_handle, icon.handle);
	}

	void setIcon(SDL_Surface* icon)
	{
		SDL_SetWindowIcon(_handle, icon);
	}
}
