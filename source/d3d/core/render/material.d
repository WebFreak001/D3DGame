module d3d.core.render.material;

import d3d.core;

alias MaterialVars = void function(ShaderProgram, RenderContext);

void defaultMaterial(ShaderProgram shader, RenderContext context)
{
}

struct Material
{
	string name;

	bool blend = false;
	bool depth = true;

	ITexture[int] textures;

	ShaderProgram shader;

	MaterialVars vars = &defaultMaterial;

	void bind(RenderContext context)
	{
		foreach (id, tex; textures)
			tex.bind(id);
		shader.bind();

		vars(shader, context);

		context.renderer.enableBlend = blend;
		context.renderer.enableDepthTest = depth;
	}
}
