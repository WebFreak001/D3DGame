module d3d.core.bitmap;

/// Bitmap containing data and size.
struct Bitmap
{
	/// Width of this bitmap
	ushort width;
	/// Height of this bitmap
	ushort height;

	/// `void[]` containing pixels. Preferably in ARGB uint format. Dependent on implementation.
	/// See Also: d3d.common.surface
	void[] pixels;
}
