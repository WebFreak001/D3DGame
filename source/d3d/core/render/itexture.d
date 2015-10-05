module d3d.core.render.itexture;

import d3d.core;

interface ITexture
{
	void create(Bitmap bmp);

	Bitmap toBitmap();

	void destroy();

	void resize(Bitmap bmp);

	void bind(uint unit);

	@property uint id();

	@property uint width();

	@property uint height();

	static @property ITexture white();
}

interface ITexture3D
{
	void create(Bitmap bmp, int depth);

	void destroy();

	void resize(Bitmap bmp, int depth);

	void bind(uint unit);

	@property uint id();

	@property uint width();

	@property uint height();

	@property uint depth();
}
