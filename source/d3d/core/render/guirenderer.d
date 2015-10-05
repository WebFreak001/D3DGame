module d3d.core.render.guirenderer;

import d3d.core;

class GUIRenderer
{
private:
	IRenderer _renderer;
	Mesh _quad;
	Material _material;
	bool _depthTestState = false;
	RenderContext _context;

	float _iwidth, _iheight;
	vec2 _size;

public:
	this(IRenderer renderer, Material material, int width, int height)
	{
		_renderer = renderer;

		_quad = renderer.createMesh(MeshUtils.createPlane(0, 1, 1, 0, 0, 1, 1, 0));

		_material = material;

		_iwidth = 1.0f / width;
		_iheight = 1.0f / height;
		_size = vec2(1, 1);

		_material.shader.registerUniforms("slot0", "color", "clip");
		_material.shader.set("slot0", 0);
		_material.shader.set("color", vec4(1, 1, 1, 1));
		_material.shader.set("clip", vec4(0, 0, 1, 1));
	}

	@property vec2 size()
	{
		return _size;
	}

	void resize(uint width, uint height)
	{
		_iwidth = 1.0f / width;
		_iheight = 1.0f / height;
		_size = vec2(width, height);
	}

	void begin(RenderContext context)
	{
		_context = context;
		_depthTestState = _renderer.enableDepthTest;
		_renderer.enableDepthTest = false;
	}

	void end()
	{
		_renderer.enableDepthTest = _depthTestState;
	}

	void renderRectangle(vec2 position, vec2 size, ITexture texture, vec4 color = vec4(1, 1, 1, 1))
	{
		_material.bind(_context);

		_material.shader.set("clip", vec4(0, 0, 1, 1));
		_material.shader.set("color", color);
		_material.shader.set("modelview", mat4.identity.translate(position.x * _iwidth * 2 - 1, -(position.y * _iheight * 2 + size.y * _iheight * 2 - 1), 0) * mat4.identity.scale(size.x * _iwidth * 2, size.y * _iheight * 2, 1));
		_material.shader.set("projection", mat4.identity);

		texture.bind(0);

		_renderer.renderMesh(_quad);
	}

	void renderRectangle(vec2 position, vec2 size, vec4 clip, ITexture texture, vec4 color = vec4(1, 1, 1, 1))
	{
		_material.bind(_context);

		_material.shader.set("clip", vec4(clip.x / cast(float) texture.width, clip.y / cast(float) texture.height, clip.z / cast(float) texture.width, clip.w / cast(float) texture.height));
		_material.shader.set("color", color);
		_material.shader.set("modelview", mat4.identity.translate(position.x * _iwidth * 2 - 1, -(position.y * _iheight * 2 + size.y * _iheight * 2 - 1), 0) * mat4.identity.scale(size.x * _iwidth * 2, size.y * _iheight * 2, 1));
		_material.shader.set("projection", mat4.identity);

		texture.bind(0);

		_renderer.renderMesh(_quad);
	}

	void renderMesh(Mesh mesh, vec2 position, vec2 size, ITexture texture, vec4 color = vec4(1, 1, 1, 1))
	{
		_material.bind(_context);

		_material.shader.set("clip", vec4(0, 0, 1, 1));
		_material.shader.set("color", color);
		_material.shader.set("modelview", mat4.identity.translate(position.x * _iwidth * 2 - 1, -(position.y * _iheight * 2 + size.y * _iheight * 2 - 1), 0) * mat4.identity.scale(size.x * _iwidth * 2, size.y * _iheight * 2, 1));
		_material.shader.set("projection", mat4.identity);

		texture.bind(0);

		_renderer.renderMesh(mesh);
	}

	void renderMesh(Mesh mesh, vec2 position, vec2 size, vec4 clip, ITexture texture, vec4 color = vec4(1, 1, 1, 1))
	{
		_material.bind(_context);

		_material.shader.set("clip", vec4(clip.x / cast(float) texture.width, clip.y / cast(float) texture.height, clip.z / cast(float) texture.width, clip.w / cast(float) texture.height));
		_material.shader.set("color", color);
		_material.shader.set("modelview", mat4.identity.translate(position.x * _iwidth * 2 - 1, -(position.y * _iheight * 2 + size.y * _iheight * 2 - 1), 0) * mat4.identity.scale(size.x * _iwidth * 2, size.y * _iheight * 2, 1));
		_material.shader.set("projection", mat4.identity);

		texture.bind(0);

		_renderer.renderMesh(mesh);
	}
}
