module d3d.core.render.shader;

import d3d.core;

///
enum ShaderType : ubyte
{
	///
	Vertex,
	///
	TessControl,
	///
	TessEvaluation,
	///
	Geometry,
	///
	Fragment
}

///
interface ShaderProgram
{
	///
	uint create();

	///
	void attach(Shader shader);

	///
	void link();

	///
	void bind();

	///
	int registerUniform(string uniform);

	///
	final void registerUniforms(T ...)(T uniforms)
	{
		foreach (uniform; uniforms)
			registerUniform(uniform);
	}

	///
	void set(T)(string uniform, T value);
}

///
interface Shader
{
	///
	bool load(ShaderType type, string content);

	///
	bool compile();

	///
	@property uint id();
}
