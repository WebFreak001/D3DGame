module d3d.gl3.gl3renderer;

import d3d.gl3;
import d3d.core;

enum BlendFunc
{
	Zero = GL_ZERO,
	One = GL_ONE,
	SrcColor = GL_SRC_COLOR,
	OneMinusSrcColor = GL_ONE_MINUS_SRC_COLOR,
	DstColor = GL_DST_COLOR,
	OneMinusDstColor = GL_ONE_MINUS_DST_COLOR,
	SrcAlpha = GL_SRC_ALPHA,
	OneMinusSrcAlpha = GL_ONE_MINUS_SRC_ALPHA,
	DstAlpha = GL_DST_ALPHA,
	OneMinusDstAlpha = GL_ONE_MINUS_DST_ALPHA,
	SrcAlphaSaturate = GL_SRC_ALPHA_SATURATE,
	Src1Color = GL_SRC1_COLOR,
	OneMinusSrc1Color = GL_ONE_MINUS_SRC1_COLOR,
	OneMinusSrc1Alpha = GL_ONE_MINUS_SRC1_ALPHA,
}

private enum bufferCount = 4;

class GL3Renderer : IRenderer
{
private:
	GUIRenderer _gui;
	int _width, _height;
	bool _blend, _depth;

public:
	@property GUIRenderer gui()
	{
		return _gui;
	}

	void attachGUI(Material material)
	{
		_gui = new GUIRenderer(this, material, _width, _height);
	}

	void setClearColor(float r, float g, float b)
	{
		glClearColor(r, g, b, 1);
	}

	void setClearDepth(double clearDepth)
	{
		glClearDepth(clearDepth);
	}

	void clearBuffer(RenderBuffer buffers)
	{
		if ((buffers & RenderBuffer.colorBuffer) == RenderBuffer.colorBuffer)
		{
			glClear(GL_COLOR_BUFFER_BIT);
		}
		if ((buffers & RenderBuffer.depthBuffer) == RenderBuffer.depthBuffer)
		{
			glClear(GL_DEPTH_BUFFER_BIT);
		}
		if ((buffers & RenderBuffer.stencilBuffer) == RenderBuffer.stencilBuffer)
		{
			glClear(GL_STENCIL_BUFFER_BIT);
		}
	}

	Mesh createMesh(Mesh mesh)
	{
		uint vao;
		glGenVertexArrays(1, &vao);
		glBindVertexArray(vao);

		uint* vbo = new uint[bufferCount].ptr;

		glGenBuffers(bufferCount, vbo);

		glBindBuffer(GL_ARRAY_BUFFER, vbo[0]);
		glBufferData(GL_ARRAY_BUFFER, vec3.sizeof * mesh.vertices.length, mesh.vertices.ptr, GL_STATIC_DRAW);
		glVertexAttribPointer(0u, 3, GL_FLOAT, cast(ubyte) 0, 0, null);
		glEnableVertexAttribArray(0);

		glBindBuffer(GL_ARRAY_BUFFER, vbo[1]);
		glBufferData(GL_ARRAY_BUFFER, vec2.sizeof * mesh.texCoords.length, mesh.texCoords.ptr, GL_STATIC_DRAW);
		glVertexAttribPointer(1u, 2, GL_FLOAT, cast(ubyte) 0, 0, null);
		glEnableVertexAttribArray(1);

		glBindBuffer(GL_ARRAY_BUFFER, vbo[2]);
		glBufferData(GL_ARRAY_BUFFER, vec3.sizeof * mesh.normals.length, mesh.normals.ptr, GL_STATIC_DRAW);
		glVertexAttribPointer(2u, 3, GL_FLOAT, cast(ubyte) 0, 0, null);
		glEnableVertexAttribArray(2);

		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, vbo[bufferCount - 1]);
		glBufferData(GL_ELEMENT_ARRAY_BUFFER, uint.sizeof * mesh.indices.length, mesh.indices.ptr, GL_STATIC_DRAW);

		glBindVertexArray(0);

		mesh.renderable = new RenderableMesh(vao, vbo, cast(uint) mesh.indices.length);

		return mesh;
	}

	void deleteMesh(Mesh mesh)
	{
		glDeleteBuffers(bufferCount, mesh.renderable.vbos);
		glDeleteVertexArrays(1, &mesh.renderable.bufferID);
	}

	void renderMesh(Mesh mesh)
	{
		glBindVertexArray(mesh.renderable.bufferID);
		glDrawElements(GL_TRIANGLES, mesh.renderable.indexLength, GL_UNSIGNED_INT, null);
	}

	void resize(uint width, uint height)
	{
		_width = width;
		_height = height;

		if (_gui)
			_gui.resize(width, height);

		glViewport(0, 0, width, height);
	}

	/// Returns a RGB ubyte[] bitmap
	Bitmap renderToBitmap()
	{
		ubyte[] pixels = new ubyte[3 * _width * _height];
		glReadPixels(0, 0, _width, _height, GL_RGB, GL_UNSIGNED_BYTE, pixels.ptr);
		return Bitmap(cast(ushort) _width, cast(ushort) _height, pixels);
	}

	ShaderProgram createShader(Shader[] shaders)
	{
		GLShaderProgram program = new GLShaderProgram();
		program.create();

		foreach (Shader shader; shaders)
		{
			program.attach(shader);
		}

		program.link();

		return program;
	}

	@property bool enableBlend()
	{
		return _blend;
	}

	@property bool enableDepthTest()
	{
		return _depth;
	}

	void blendFunc(BlendFunc sfactor, BlendFunc dfactor)
	{
		glBlendFunc(sfactor, dfactor);
	}

	@property void enableBlend(bool value)
	{
		if (_blend == value)
			return;
		_blend = value;
		if (value)
			glEnable(GL_BLEND);
		else
			glDisable(GL_BLEND);
	}

	@property void enableDepthTest(bool value)
	{
		if (_depth == value)
			return;
		_depth = value;
		if (value)
			glEnable(GL_DEPTH_TEST);
		else
			glDisable(GL_DEPTH_TEST);
	}
}
