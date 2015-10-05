module d3d.core.color;

import d3d.core;

/// Color structure for Bitmaps and converting HSL -> RGB and Hex -> float[3].
/// Can be converted to a `SDL_Color`.
/// Only contains RGB Colors.
struct Color
{
private:
	ubyte _r, _g, _b;

public:
	/// HTML color <span style='background-color: AliceBlue'>AliceBlue</span>
	static const Color aliceBlue = Color.fromRGB(0xF0F8FF);
	/// HTML color <span style='background-color: AntiqueWhite'>AntiqueWhite</span>
	static const Color antiqueWhite = Color.fromRGB(0xFAEBD7);
	/// HTML color <span style='background-color: Aqua'>Aqua</span>
	static const Color aqua = Color.fromRGB(0x00FFFF);
	/// HTML color <span style='background-color: Aquamarine'>Aquamarine</span>
	static const Color aquamarine = Color.fromRGB(0x7FFFD4);
	/// HTML color <span style='background-color: Azure'>Azure</span>
	static const Color azure = Color.fromRGB(0xF0FFFF);
	/// HTML color <span style='background-color: Beige'>Beige</span>
	static const Color beige = Color.fromRGB(0xF5F5DC);
	/// HTML color <span style='background-color: Bisque'>Bisque</span>
	static const Color bisque = Color.fromRGB(0xFFE4C4);
	/// HTML color <span style='background-color: Black'>Black</span>
	static const Color black = Color.fromRGB(0x000000);
	/// HTML color <span style='background-color: BlanchedAlmond'>BlanchedAlmond</span>
	static const Color blanchedAlmond = Color.fromRGB(0xFFEBCD);
	/// HTML color <span style='background-color: Blue'>Blue</span>
	static const Color blue = Color.fromRGB(0x0000FF);
	/// HTML color <span style='background-color: BlueViolet'>BlueViolet</span>
	static const Color blueViolet = Color.fromRGB(0x8A2BE2);
	/// HTML color <span style='background-color: Brown'>Brown</span>
	static const Color brown = Color.fromRGB(0xA52A2A);
	/// HTML color <span style='background-color: BurlyWood'>BurlyWood</span>
	static const Color burlyWood = Color.fromRGB(0xDEB887);
	/// HTML color <span style='background-color: CadetBlue'>CadetBlue</span>
	static const Color cadetBlue = Color.fromRGB(0x5F9EA0);
	/// HTML color <span style='background-color: Chartreuse'>Chartreuse</span>
	static const Color chartreuse = Color.fromRGB(0x7FFF00);
	/// HTML color <span style='background-color: Chocolate'>Chocolate</span>
	static const Color chocolate = Color.fromRGB(0xD2691E);
	/// HTML color <span style='background-color: Coral'>Coral</span>
	static const Color coral = Color.fromRGB(0xFF7F50);
	/// HTML color <span style='background-color: CornflowerBlue'>CornflowerBlue</span>
	static const Color cornflowerBlue = Color.fromRGB(0x6495ED);
	/// HTML color <span style='background-color: Cornsilk'>Cornsilk</span>
	static const Color cornsilk = Color.fromRGB(0xFFF8DC);
	/// HTML color <span style='background-color: Crimson'>Crimson</span>
	static const Color crimson = Color.fromRGB(0xDC143C);
	/// HTML color <span style='background-color: Cyan'>Cyan</span>
	static const Color cyan = Color.fromRGB(0x00FFFF);
	/// HTML color <span style='background-color: DarkBlue'>DarkBlue</span>
	static const Color darkBlue = Color.fromRGB(0x00008B);
	/// HTML color <span style='background-color: DarkCyan'>DarkCyan</span>
	static const Color darkCyan = Color.fromRGB(0x008B8B);
	/// HTML color <span style='background-color: DarkGoldenRod'>DarkGoldenRod</span>
	static const Color darkGoldenRod = Color.fromRGB(0xB8860B);
	/// HTML color <span style='background-color: DarkGray'>DarkGray</span>
	static const Color darkGray = Color.fromRGB(0xA9A9A9);
	/// HTML color <span style='background-color: DarkGreen'>DarkGreen</span>
	static const Color darkGreen = Color.fromRGB(0x006400);
	/// HTML color <span style='background-color: DarkKhaki'>DarkKhaki</span>
	static const Color darkKhaki = Color.fromRGB(0xBDB76B);
	/// HTML color <span style='background-color: DarkMagenta'>DarkMagenta</span>
	static const Color darkMagenta = Color.fromRGB(0x8B008B);
	/// HTML color <span style='background-color: DarkOliveGreen'>DarkOliveGreen</span>
	static const Color darkOliveGreen = Color.fromRGB(0x556B2F);
	/// HTML color <span style='background-color: DarkOrange'>DarkOrange</span>
	static const Color darkOrange = Color.fromRGB(0xFF8C00);
	/// HTML color <span style='background-color: DarkOrchid'>DarkOrchid</span>
	static const Color darkOrchid = Color.fromRGB(0x9932CC);
	/// HTML color <span style='background-color: DarkRed'>DarkRed</span>
	static const Color darkRed = Color.fromRGB(0x8B0000);
	/// HTML color <span style='background-color: DarkSalmon'>DarkSalmon</span>
	static const Color darkSalmon = Color.fromRGB(0xE9967A);
	/// HTML color <span style='background-color: DarkSeaGreen'>DarkSeaGreen</span>
	static const Color darkSeaGreen = Color.fromRGB(0x8FBC8F);
	/// HTML color <span style='background-color: DarkSlateBlue'>DarkSlateBlue</span>
	static const Color darkSlateBlue = Color.fromRGB(0x483D8B);
	/// HTML color <span style='background-color: DarkSlateGray'>DarkSlateGray</span>
	static const Color darkSlateGray = Color.fromRGB(0x2F4F4F);
	/// HTML color <span style='background-color: DarkTurquoise'>DarkTurquoise</span>
	static const Color darkTurquoise = Color.fromRGB(0x00CED1);
	/// HTML color <span style='background-color: DarkViolet'>DarkViolet</span>
	static const Color darkViolet = Color.fromRGB(0x9400D3);
	/// HTML color <span style='background-color: DeepPink'>DeepPink</span>
	static const Color deepPink = Color.fromRGB(0xFF1493);
	/// HTML color <span style='background-color: DeepSkyBlue'>DeepSkyBlue</span>
	static const Color deepSkyBlue = Color.fromRGB(0x00BFFF);
	/// HTML color <span style='background-color: DimGray'>DimGray</span>
	static const Color dimGray = Color.fromRGB(0x696969);
	/// HTML color <span style='background-color: DodgerBlue'>DodgerBlue</span>
	static const Color dodgerBlue = Color.fromRGB(0x1E90FF);
	/// HTML color <span style='background-color: FireBrick'>FireBrick</span>
	static const Color fireBrick = Color.fromRGB(0xB22222);
	/// HTML color <span style='background-color: FloralWhite'>FloralWhite</span>
	static const Color floralWhite = Color.fromRGB(0xFFFAF0);
	/// HTML color <span style='background-color: ForestGreen'>ForestGreen</span>
	static const Color forestGreen = Color.fromRGB(0x228B22);
	/// HTML color <span style='background-color: Fuchsia'>Fuchsia</span>
	static const Color fuchsia = Color.fromRGB(0xFF00FF);
	/// HTML color <span style='background-color: Gainsboro'>Gainsboro</span>
	static const Color gainsboro = Color.fromRGB(0xDCDCDC);
	/// HTML color <span style='background-color: GhostWhite'>GhostWhite</span>
	static const Color ghostWhite = Color.fromRGB(0xF8F8FF);
	/// HTML color <span style='background-color: Gold'>Gold</span>
	static const Color gold = Color.fromRGB(0xFFD700);
	/// HTML color <span style='background-color: GoldenRod'>GoldenRod</span>
	static const Color goldenRod = Color.fromRGB(0xDAA520);
	/// HTML color <span style='background-color: Gray'>Gray</span>
	static const Color gray = Color.fromRGB(0x808080);
	/// HTML color <span style='background-color: Green'>Green</span>
	static const Color green = Color.fromRGB(0x008000);
	/// HTML color <span style='background-color: GreenYellow'>GreenYellow</span>
	static const Color greenYellow = Color.fromRGB(0xADFF2F);
	/// HTML color <span style='background-color: HoneyDew'>HoneyDew</span>
	static const Color honeyDew = Color.fromRGB(0xF0FFF0);
	/// HTML color <span style='background-color: HotPink'>HotPink</span>
	static const Color hotPink = Color.fromRGB(0xFF69B4);
	/// HTML color <span style='background-color: IndianRed'>IndianRed</span>
	static const Color indianRed = Color.fromRGB(0xCD5C5C);
	/// HTML color <span style='background-color: Indigo'>Indigo</span>
	static const Color indigo = Color.fromRGB(0x4B0082);
	/// HTML color <span style='background-color: Ivory'>Ivory</span>
	static const Color ivory = Color.fromRGB(0xFFFFF0);
	/// HTML color <span style='background-color: Khaki'>Khaki</span>
	static const Color khaki = Color.fromRGB(0xF0E68C);
	/// HTML color <span style='background-color: Lavender'>Lavender</span>
	static const Color lavender = Color.fromRGB(0xE6E6FA);
	/// HTML color <span style='background-color: LavenderBlush'>LavenderBlush</span>
	static const Color lavenderBlush = Color.fromRGB(0xFFF0F5);
	/// HTML color <span style='background-color: LawnGreen'>LawnGreen</span>
	static const Color lawnGreen = Color.fromRGB(0x7CFC00);
	/// HTML color <span style='background-color: LemonChiffon'>LemonChiffon</span>
	static const Color lemonChiffon = Color.fromRGB(0xFFFACD);
	/// HTML color <span style='background-color: LightBlue'>LightBlue</span>
	static const Color lightBlue = Color.fromRGB(0xADD8E6);
	/// HTML color <span style='background-color: LightCoral'>LightCoral</span>
	static const Color lightCoral = Color.fromRGB(0xF08080);
	/// HTML color <span style='background-color: LightCyan'>LightCyan</span>
	static const Color lightCyan = Color.fromRGB(0xE0FFFF);
	/// HTML color <span style='background-color: LightGoldenRodYellow'>LightGoldenRodYellow</span>
	static const Color lightGoldenRodYellow = Color.fromRGB(0xFAFAD2);
	/// HTML color <span style='background-color: LightGray'>LightGray</span>
	static const Color lightGray = Color.fromRGB(0xD3D3D3);
	/// HTML color <span style='background-color: LightGreen'>LightGreen</span>
	static const Color lightGreen = Color.fromRGB(0x90EE90);
	/// HTML color <span style='background-color: LightPink'>LightPink</span>
	static const Color lightPink = Color.fromRGB(0xFFB6C1);
	/// HTML color <span style='background-color: LightSalmon'>LightSalmon</span>
	static const Color lightSalmon = Color.fromRGB(0xFFA07A);
	/// HTML color <span style='background-color: LightSeaGreen'>LightSeaGreen</span>
	static const Color lightSeaGreen = Color.fromRGB(0x20B2AA);
	/// HTML color <span style='background-color: LightSkyBlue'>LightSkyBlue</span>
	static const Color lightSkyBlue = Color.fromRGB(0x87CEFA);
	/// HTML color <span style='background-color: LightSlateGray'>LightSlateGray</span>
	static const Color lightSlateGray = Color.fromRGB(0x778899);
	/// HTML color <span style='background-color: LightSteelBlue'>LightSteelBlue</span>
	static const Color lightSteelBlue = Color.fromRGB(0xB0C4DE);
	/// HTML color <span style='background-color: LightYellow'>LightYellow</span>
	static const Color lightYellow = Color.fromRGB(0xFFFFE0);
	/// HTML color <span style='background-color: Lime'>Lime</span>
	static const Color lime = Color.fromRGB(0x00FF00);
	/// HTML color <span style='background-color: LimeGreen'>LimeGreen</span>
	static const Color limeGreen = Color.fromRGB(0x32CD32);
	/// HTML color <span style='background-color: Linen'>Linen</span>
	static const Color linen = Color.fromRGB(0xFAF0E6);
	/// HTML color <span style='background-color: Magenta'>Magenta</span>
	static const Color magenta = Color.fromRGB(0xFF00FF);
	/// HTML color <span style='background-color: Maroon'>Maroon</span>
	static const Color maroon = Color.fromRGB(0x800000);
	/// HTML color <span style='background-color: MediumAquaMarine'>MediumAquaMarine</span>
	static const Color mediumAquaMarine = Color.fromRGB(0x66CDAA);
	/// HTML color <span style='background-color: MediumBlue'>MediumBlue</span>
	static const Color mediumBlue = Color.fromRGB(0x0000CD);
	/// HTML color <span style='background-color: MediumOrchid'>MediumOrchid</span>
	static const Color mediumOrchid = Color.fromRGB(0xBA55D3);
	/// HTML color <span style='background-color: MediumPurple'>MediumPurple</span>
	static const Color mediumPurple = Color.fromRGB(0x9370DB);
	/// HTML color <span style='background-color: MediumSeaGreen'>MediumSeaGreen</span>
	static const Color mediumSeaGreen = Color.fromRGB(0x3CB371);
	/// HTML color <span style='background-color: MediumSlateBlue'>MediumSlateBlue</span>
	static const Color mediumSlateBlue = Color.fromRGB(0x7B68EE);
	/// HTML color <span style='background-color: MediumSpringGreen'>MediumSpringGreen</span>
	static const Color mediumSpringGreen = Color.fromRGB(0x00FA9A);
	/// HTML color <span style='background-color: MediumTurquoise'>MediumTurquoise</span>
	static const Color mediumTurquoise = Color.fromRGB(0x48D1CC);
	/// HTML color <span style='background-color: MediumVioletRed'>MediumVioletRed</span>
	static const Color mediumVioletRed = Color.fromRGB(0xC71585);
	/// HTML color <span style='background-color: MidnightBlue'>MidnightBlue</span>
	static const Color midnightBlue = Color.fromRGB(0x191970);
	/// HTML color <span style='background-color: MintCream'>MintCream</span>
	static const Color mintCream = Color.fromRGB(0xF5FFFA);
	/// HTML color <span style='background-color: MistyRose'>MistyRose</span>
	static const Color mistyRose = Color.fromRGB(0xFFE4E1);
	/// HTML color <span style='background-color: Moccasin'>Moccasin</span>
	static const Color moccasin = Color.fromRGB(0xFFE4B5);
	/// HTML color <span style='background-color: NavajoWhite'>NavajoWhite</span>
	static const Color navajoWhite = Color.fromRGB(0xFFDEAD);
	/// HTML color <span style='background-color: Navy'>Navy</span>
	static const Color navy = Color.fromRGB(0x000080);
	/// HTML color <span style='background-color: OldLace'>OldLace</span>
	static const Color oldLace = Color.fromRGB(0xFDF5E6);
	/// HTML color <span style='background-color: Olive'>Olive</span>
	static const Color olive = Color.fromRGB(0x808000);
	/// HTML color <span style='background-color: OliveDrab'>OliveDrab</span>
	static const Color oliveDrab = Color.fromRGB(0x6B8E23);
	/// HTML color <span style='background-color: Orange'>Orange</span>
	static const Color orange = Color.fromRGB(0xFFA500);
	/// HTML color <span style='background-color: OrangeRed'>OrangeRed</span>
	static const Color orangeRed = Color.fromRGB(0xFF4500);
	/// HTML color <span style='background-color: Orchid'>Orchid</span>
	static const Color orchid = Color.fromRGB(0xDA70D6);
	/// HTML color <span style='background-color: PaleGoldenRod'>PaleGoldenRod</span>
	static const Color paleGoldenRod = Color.fromRGB(0xEEE8AA);
	/// HTML color <span style='background-color: PaleGreen'>PaleGreen</span>
	static const Color paleGreen = Color.fromRGB(0x98FB98);
	/// HTML color <span style='background-color: PaleTurquoise'>PaleTurquoise</span>
	static const Color paleTurquoise = Color.fromRGB(0xAFEEEE);
	/// HTML color <span style='background-color: PaleVioletRed'>PaleVioletRed</span>
	static const Color paleVioletRed = Color.fromRGB(0xDB7093);
	/// HTML color <span style='background-color: PapayaWhip'>PapayaWhip</span>
	static const Color papayaWhip = Color.fromRGB(0xFFEFD5);
	/// HTML color <span style='background-color: PeachPuff'>PeachPuff</span>
	static const Color peachPuff = Color.fromRGB(0xFFDAB9);
	/// HTML color <span style='background-color: Peru'>Peru</span>
	static const Color peru = Color.fromRGB(0xCD853F);
	/// HTML color <span style='background-color: Pink'>Pink</span>
	static const Color pink = Color.fromRGB(0xFFC0CB);
	/// HTML color <span style='background-color: Plum'>Plum</span>
	static const Color plum = Color.fromRGB(0xDDA0DD);
	/// HTML color <span style='background-color: PowderBlue'>PowderBlue</span>
	static const Color powderBlue = Color.fromRGB(0xB0E0E6);
	/// HTML color <span style='background-color: Purple'>Purple</span>
	static const Color purple = Color.fromRGB(0x800080);
	/// HTML color <span style='background-color: RebeccaPurple'>RebeccaPurple</span>
	static const Color rebeccaPurple = Color.fromRGB(0x663399);
	/// HTML color <span style='background-color: Red'>Red</span>
	static const Color red = Color.fromRGB(0xFF0000);
	/// HTML color <span style='background-color: RosyBrown'>RosyBrown</span>
	static const Color rosyBrown = Color.fromRGB(0xBC8F8F);
	/// HTML color <span style='background-color: RoyalBlue'>RoyalBlue</span>
	static const Color royalBlue = Color.fromRGB(0x4169E1);
	/// HTML color <span style='background-color: SaddleBrown'>SaddleBrown</span>
	static const Color saddleBrown = Color.fromRGB(0x8B4513);
	/// HTML color <span style='background-color: Salmon'>Salmon</span>
	static const Color salmon = Color.fromRGB(0xFA8072);
	/// HTML color <span style='background-color: SandyBrown'>SandyBrown</span>
	static const Color sandyBrown = Color.fromRGB(0xF4A460);
	/// HTML color <span style='background-color: SeaGreen'>SeaGreen</span>
	static const Color seaGreen = Color.fromRGB(0x2E8B57);
	/// HTML color <span style='background-color: SeaShell'>SeaShell</span>
	static const Color seaShell = Color.fromRGB(0xFFF5EE);
	/// HTML color <span style='background-color: Sienna'>Sienna</span>
	static const Color sienna = Color.fromRGB(0xA0522D);
	/// HTML color <span style='background-color: Silver'>Silver</span>
	static const Color silver = Color.fromRGB(0xC0C0C0);
	/// HTML color <span style='background-color: SkyBlue'>SkyBlue</span>
	static const Color skyBlue = Color.fromRGB(0x87CEEB);
	/// HTML color <span style='background-color: SlateBlue'>SlateBlue</span>
	static const Color slateBlue = Color.fromRGB(0x6A5ACD);
	/// HTML color <span style='background-color: SlateGray'>SlateGray</span>
	static const Color slateGray = Color.fromRGB(0x708090);
	/// HTML color <span style='background-color: Snow'>Snow</span>
	static const Color snow = Color.fromRGB(0xFFFAFA);
	/// HTML color <span style='background-color: SpringGreen'>SpringGreen</span>
	static const Color springGreen = Color.fromRGB(0x00FF7F);
	/// HTML color <span style='background-color: SteelBlue'>SteelBlue</span>
	static const Color steelBlue = Color.fromRGB(0x4682B4);
	/// HTML color <span style='background-color: Tan'>Tan</span>
	static const Color tan = Color.fromRGB(0xD2B48C);
	/// HTML color <span style='background-color: Teal'>Teal</span>
	static const Color teal = Color.fromRGB(0x008080);
	/// HTML color <span style='background-color: Thistle'>Thistle</span>
	static const Color thistle = Color.fromRGB(0xD8BFD8);
	/// HTML color <span style='background-color: Tomato'>Tomato</span>
	static const Color tomato = Color.fromRGB(0xFF6347);
	/// HTML color <span style='background-color: Turquoise'>Turquoise</span>
	static const Color turquoise = Color.fromRGB(0x40E0D0);
	/// HTML color <span style='background-color: Violet'>Violet</span>
	static const Color violet = Color.fromRGB(0xEE82EE);
	/// HTML color <span style='background-color: Wheat'>Wheat</span>
	static const Color wheat = Color.fromRGB(0xF5DEB3);
	/// HTML color <span style='background-color: White'>White</span>
	static const Color white = Color.fromRGB(0xFFFFFF);
	/// HTML color <span style='background-color: WhiteSmoke'>WhiteSmoke</span>
	static const Color whiteSmoke = Color.fromRGB(0xF5F5F5);
	/// HTML color <span style='background-color: Yellow'>Yellow</span>
	static const Color yellow = Color.fromRGB(0xFFFF00);
	/// HTML color <span style='background-color: YellowGreen'>YellowGreen</span>
	static const Color yellowGreen = Color.fromRGB(0x9ACD32);

	/// Creates a new 24 bit color using 3x 8 bit components.
	/// Params:
	///     r = Red value in range 0 - 255
	///     g = Green value in range 0 - 255
	///     b = Blue value in range 0 - 255
	this(ubyte r, ubyte g, ubyte b)
	{
		_r = r;
		_g = g;
		_b = b;
	}

	/// Creates a new 24 bit color.
	/// Params:
	///     hex = integer in RGB byte order
	static Color fromRGB(const int hex)
	{
		return Color((hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF);
	}

	/// Creates a new 24 bit color.
	/// Params:
	///     hex = integer in BGR byte order
	static Color fromBGR(const int hex)
	{
		return Color(hex & 0xFF, (hex >> 8) & 0xFF, (hex >> 16) & 0xFF);
	}

	/// Converts from HSL to RGB
	/// Params:
	///     hue =        Hue in range 0 - 1
	///     saturation = Saturation in range 0 - 1
	///     lightness =  Lightness in range 0 - 1
	void fromHSL(double hue, double saturation, double lightness)
	{
		immutable double v = lightness <= 0.5 ? (lightness * (1 + saturation)) : (1 + saturation - lightness * saturation);
		double r, g, b;
		r = g = b = 1;

		if (v > 0)
		{
			double m;
			double sv;
			int sextant;
			double fract, vsf, mid1, mid2;

			m = lightness + lightness - v;
			sv = (v - m) / v;
			hue *= 6.0;
			sextant = cast(int) hue;
			fract = hue - sextant;
			vsf = v * sv * fract;
			mid1 = m + vsf;
			mid2 = v - vsf;
			switch (sextant)
			{
			case 0:
				r = v;
				g = mid1;
				b = m;
				break;
			case 1:
				r = mid2;
				g = v;
				b = m;
				break;
			case 2:
				r = m;
				g = v;
				b = mid1;
				break;
			case 3:
				r = m;
				g = mid2;
				b = v;
				break;
			case 4:
				r = mid1;
				g = m;
				b = v;
				break;
			case 5:
				r = v;
				g = m;
				b = mid2;
				break;
			default:
				break;
			}
		}
		_r = cast(ubyte) (r * 255);
		_g = cast(ubyte) (g * 255);
		_b = cast(ubyte) (b * 255);
	}

	/// Red value in range 0 - 255 as a ubyte.
	@property ref ubyte R()
	{
		return _r;
	}

	/// Green value in range 0 - 255 as a ubyte.
	@property ref ubyte G()
	{
		return _g;
	}

	/// Blue value in range 0 - 255 as a ubyte.
	@property ref ubyte B()
	{
		return _b;
	}

	/// Red value in range 0 - 1 as a float.
	@property float fR() const
	{
		return _r * 0.00392156862f;
	}

	/// Green value in range 0 - 1 as a float.
	@property float fG() const
	{
		return _g * 0.00392156862f;
	}

	/// Blue value in range 0 - 1 as a float.
	@property float fB() const
	{
		return _b * 0.00392156862f;
	}

	/// RGB in range 0 - 1 as vec3
	@property vec3 f() const
	{
		return vec3(fR, fG, fB);
	}

	/// Color as RGB hex.
	@property int RGB() const
	{
		return _r << 16 | _g << 8 | _b;
	}

	/// Color as BGR hex.
	@property int BGR() const
	{
		return _r | _g << 8 | _b << 16;
	}
}
