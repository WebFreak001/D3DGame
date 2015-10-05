module d3d.core.iview;

import d3d.core;

/// Abstract class for Views. (Window, Win8MetroApp, AndroidView, etc.)
abstract class IView
{
private:
	bool _created = false;
	Scene _scene = null;
	IRenderer _renderer = null;

protected:
	abstract void onCreate();
	abstract void onDraw();
	abstract bool onUpdate(float delta);

	void draw2D(RenderContext context)
	{
		if (scene !is null)
			scene.performDraw2D(context);
	}

	void draw3D(RenderContext context)
	{
		if (scene !is null)
			scene.performDraw3D(context);
	}

	void update(float delta)
	{
		if (_scene !is null)
			_scene.performUpdate(delta);
	}

public:
	void create()
	{
		onCreate();

		if (!_created)
		{
			_created = true;
		}
	}

	@property void scene(Scene value)
	in
	{
		assert(value !is null);
	}
	body
	{
		_scene = value;
		if (_created)
		{
			_scene.view = this;
			_scene.init();
		}
	}

	@property Scene scene()
	{
		return _scene;
	}

	@property ref IRenderer renderer()
	{
		return _renderer;
	}

	void performDraw()
	{
		onDraw();
	}

	bool performUpdate(float delta)
	{
		return onUpdate(delta);
	}
}
