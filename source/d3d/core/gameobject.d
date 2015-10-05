module d3d.core.gameobject;

import d3d.core;

import std.algorithm;

abstract class GameObject
{
private:
	GameObject[] _children;
	GameObject _parent;
	bool _enabled = true;
	IRenderer _renderer;
	IComponent[] _components;

public:
	Transform transform = Transform();

protected:
	void update(float deltaTime)
	{
	}

	void draw3D(RenderContext context)
	{
	}

	void draw2D(RenderContext context)
	{
	}

	@property GameObject parent()
	{
		return _parent;
	}

public:
	alias addGameObject = addChild;

	GameObject addChild(GameObject child)
	{
		if (child == this)
			return child;
		child._parent = this;
		child.transform.parent = &transform;
		_children ~= child;
		return child;
	}

	void removeChild(GameObject child)
	{
		_children = remove!(c => c == child)(_children);
	}

	@property GameObject[] children()
	{
		return _children;
	}

	void performUpdate(float deltaTime)
	{
		if (_enabled)
		{
			foreach (com; _components)
			{
				com.preUpdate(deltaTime);
			}

			update(deltaTime);
			foreach (child; _children)
				child.performUpdate(deltaTime);

			foreach (com; _components)
			{
				com.update(deltaTime);
			}
		}
	}

	void performDraw3D(RenderContext context)
	{
		if (_enabled)
		{
			foreach (com; _components)
			{
				com.preDraw3D(context);
			}

			draw3D(context);
			foreach (child; _children)
				child.performDraw3D(context);

			foreach (com; _components)
			{
				com.draw3D(context);
			}
		}
	}

	void performDraw2D(RenderContext context)
	{
		if (_enabled)
		{
			foreach (com; _components)
			{
				com.preDraw2D(context);
			}

			draw2D(context);
			foreach (child; _children)
				child.performDraw2D(context);

			foreach (com; _components)
			{
				com.draw2D(context);
			}
		}
	}

	void addComponent(IComponent component)
	{
		_components ~= component;
		component.add(this);
	}

	@property ref bool enabled()
	{
		return _enabled;
	}

	@property ref IRenderer renderer()
	{
		return _renderer;
	}
}

alias Layer = RenderLayer;

abstract class RenderLayer : GameObject
{
private:
	Scene _scene;

public:
	abstract void init(Scene scene);

	override GameObject addChild(GameObject child)
	{
		if (child == this)
			return child;
		child.renderer = _renderer;
		child._parent = this;
		_children ~= child;
		return child;
	}

	@property ref Scene scene()
	{
		return _scene;
	}
}

class Scene : GameObject
{
private:
	Scene _next = null;
	IView _view;

public:
	abstract void init();

	@property ref Scene next()
	{
		return _next;
	}

	@property ref auto view()
	{
		return _view;
	}

	alias addLayer = addChild;

	override GameObject addChild(GameObject child)
	{
		if (child == this)
			return child;

		if (cast(RenderLayer) child)
			(cast(RenderLayer) child).init(this);

		child.renderer = _renderer;
		child._parent = this;
		_children ~= child;
		return child;
	}
}
