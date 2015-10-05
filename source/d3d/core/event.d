module d3d.core.event;

import std.algorithm;

class Event(T ...)
{
private:
	alias EventMethod = void delegate(Object, T);
	EventMethod[] _funcs;

public:
	void add(in EventMethod func)
	{
		if (!_funcs.canFind(func))
			_funcs ~= func;
	}

	void remove(in EventMethod func)
	{
		if (_funcs.canFind(func))
		{
			EventMethod[] newFuncs;
			foreach (EventMethod method; _funcs)
			{
				if (func != method)
					newFuncs ~= method;
			}
			_funcs = newFuncs;
		}
	}

	void opCall(Object sender, T args)
	{
		foreach (ref func; _funcs)
			func(sender, args);
	}
}

/// Event without arguments
class Trigger
{
private:
	alias EventMethod = void delegate(Object);
	EventMethod[] _funcs;

public:
	void add(in EventMethod func)
	{
		if (!_funcs.canFind(func))
			_funcs ~= func;
	}

	void remove(in EventMethod func)
	{
		if (_funcs.canFind(func))
		{
			EventMethod[] newFuncs;
			foreach (EventMethod method; _funcs)
			{
				if (func != method)
					newFuncs ~= method;
			}
			_funcs = newFuncs;
		}
	}

	void opCall(Object sender)
	{
		foreach (ref func; _funcs)
			func(sender);
	}
}
