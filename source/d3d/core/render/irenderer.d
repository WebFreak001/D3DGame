module d3d.core.render.irenderer;

import d3d.core;

enum RenderBuffer : ubyte
{
	colorBuffer = 1 << 0,
	depthBuffer = 1 << 1,
	stencilBuffer = 1 << 2,

	colorDepth = colorBuffer | depthBuffer,
	colorDepthStencil = colorBuffer | depthBuffer | stencilBuffer,
	colorStencil = colorBuffer | stencilBuffer,
	depthStencil = depthBuffer | stencilBuffer,
}

interface IRenderer
{
	@property GUIRenderer gui();
	void attachGUI(Material material);

	final void setClearColor(Color color)
	{
		setClearColor(color.fR, color.fG, color.fB);
	}

	void setClearColor(float r, float g, float b);

	void setClearDepth(double clearDepth);

	void clearBuffer(RenderBuffer buffers);

	Mesh createMesh(Mesh mesh);
	void deleteMesh(Mesh mesh);
	void renderMesh(Mesh mesh);

	void resize(uint width, uint height);

	Bitmap renderToBitmap();

	ShaderProgram createShader(Shader[] shaders);

	@property bool enableBlend();
	@property bool enableDepthTest();

	@property void enableBlend(bool value);
	@property void enableDepthTest(bool value);
}
