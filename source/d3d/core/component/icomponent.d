module d3d.core.component.icomponent;

import d3d.core;

abstract class IComponent
{
	void add(GameObject object);
	void preUpdate(float delta);
	void update(float delta);
	void preDraw3D(RenderContext context);
	void draw3D(RenderContext context);
	void preDraw2D(RenderContext context);
	void draw2D(RenderContext context);
}
