module d3d.core.context;

import d3d.core;

import std.datetime;

private class EncoContext(alias Components)
{
private:
	StopWatch _timer;
	TickDuration _delta;
	IView _view;

public:
	~this()
	{
		Components.unloadComponents();
	}

	@property ref IView view()
	{
		return _view;
	}

	@property float deltaTime()
	{
		return _delta.to!("seconds", float);
	}

	void start()
	{
		_view.create();
	}

	void stop()
	{
		_view.destroy();
	}

	bool update()
	{
		_timer.start();
		return _view.performUpdate(deltaTime);
	}

	void draw()
	{
		_view.performDraw();
	}

	void endUpdate()
	{
		_timer.stop();
		_delta = _timer.peek();
		_timer.reset();
	}
}

auto createContext(libraries ...)()
{
	import std.traits : fullyQualifiedName;
	alias libs = ComponentLoader!(libraries);
	libs.loadComponents();
	pragma(msg, fullyQualifiedName!libs);
	return new EncoContext!(libs);
}
