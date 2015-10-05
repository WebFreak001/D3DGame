module d3d.common.surface;

import d3d.common;

import std.string;

/// Class wrapping SDL_Surface.
final class Surface
{
private:
	SDL_Surface* _handle;
	Bitmap bitmap;

public:
	@disable this();

	/// Creates a surface from an existing one.
	this(SDL_Surface * surface)
	{
		_handle = surface;
		bitmap.width = cast(ushort) width;
		bitmap.height = cast(ushort) height;
		bitmap.pixels = _handle.pixels[0 .. width * height];
	}

	/// Creates an empty surface.
	this(int width, int height, int depth)
	{
		this(SDL_CreateRGBSurface(0, width, height, depth, 0, 0, 0, 0));
	}

	~this()
	{
		SDL_FreeSurface(_handle);
		_handle = null;
	}

	///
	@property SDL_Surface* handle()
	{
		return _handle;
	}

	///
	@property auto format()
	{
		return _handle.format;
	}

	///
	@property bool valid()
	{
		return _handle !is null;
	}

	///
	@property int width()
	{
		return _handle.w;
	}

	///
	@property int height()
	{
		return _handle.h;
	}

	/// Saves the current content to a bmp file.
	void saveBMP(string file)
	{
		SDL_SaveBMP(_handle, file.toStringz());
	}

	/// Maps R,G,B to an unsigned integer in the surface `format`.
	uint mapRGB(Color color)
	{
		return SDL_MapRGB(_handle.format, color.R, color.G, color.B);
	}

	/// Unmaps an unsigned integer to the R,G,B components in the surface `format`.
	Color unmapRGB(uint color)
	{
		ubyte r, g, b;
		SDL_GetRGB(color, _handle.format, &r, &g, &b);
		return Color(r, g, b);
	}

	/// Fills the entire picture with one color.
	void fill(Color color)
	{
		SDL_FillRect(_handle, null, mapRGB(color));
	}

	/// Fills a rectangle in the picture with one color.
	void fill(int x, int y, int width, int height, Color color)
	{
		SDL_FillRect(_handle, new SDL_Rect(x, y, width, height), mapRGB(color));
	}

	/// Gets the pixel at pixel `i`.
	uint opIndex(int i)
	{
		return (cast(uint*) _handle.pixels)[i];
	}

	/// Gets the pixel at the pixel at position `x`, `y`.
	uint opIndex(int x, int y)
	{
		return opIndex(x + y * width);
	}

	/// Sets the pixel at pixel `i` to `color`.
	void opIndexAssign(uint color, int i)
	{
		(cast(uint*) _handle.pixels)[i] = color;
	}

	/// Sets the pixel at the pixel at position `x`, `y` to `color`.
	void opIndexAssign(uint color, int x, int y)
	{
		opIndexAssign(color, x + y * width);
	}

	/// Converts the `source` surface to a new format and returns a new surface.
	static Surface convert(Surface source, const SDL_PixelFormat* destFormat)
	{
		return new Surface(SDL_ConvertSurface(source.handle, destFormat, 0));
	}
}
