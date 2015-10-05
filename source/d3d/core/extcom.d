module d3d.core.extcom;

/// Component will get called after `target` and `target` must exist.
Depend depend(string target)
{
	return Depend(target);
}

private struct Depend
{
	/// Fully qualified name (e.g. `d3d.common.sdlcomponent.SDLComponent`) for the target.
	string target;
}

/// Component will get called after `target`.
SoftDepend softdepend(string target)
{
	return SoftDepend(target);
}

private struct SoftDepend
{
	/// Fully qualified name (e.g. `d3d.common.sdlcomponent.SDLComponent`) for the target.
	string target;
}

/// Loads components from a Type array. Will get called by D3D.
template ComponentLoader(components ...)
{
	import std.traits : fullyQualifiedName;
	import std.algorithm : canFind;

	string name;
	string target;
	string[] loaded;
	string[] total;

	/// Unloads all previusly loaded components. Will get called by D3D.
	void unloadComponents()
	{
		foreach (component; components)
			component.detach();
	}

	void loadComponents()
	{
		foreach (component; components)
		{
			total ~= fullyQualifiedName!component;
		}

		foreach (component; components)
		{
			name = fullyQualifiedName!component;
			foreach (attribute; __traits (getAttributes, component))
			{
				// I have no idea how to store types and reorder them at compile time, so we force the developer to put dependencies in correct order.
				static if (is (typeof(attribute) == Depend))
				{
					target = attribute.target;
					assert(loaded.canFind(target), target ~ " must be loaded before " ~ name);
				}
				static if (is (typeof(attribute) == SoftDepend))
				{
					target = attribute.target;
					assert(!total.canFind(target) || loaded.canFind(target), target ~ " must be loaded before " ~ name ~ " or omitted!");
				}
			}
			loaded ~= name;
			component.attach();
		}
	}
}
