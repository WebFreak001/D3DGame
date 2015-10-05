module d3d.gl3.gl3shader;

import d3d.core;
import d3d.gl3;

import std.conv;
import std.string;

class GLShaderProgram : ShaderProgram
{
private:
	uint _program;
	int[string] _properties;
public:
	uint create()
	{
		return _program = glCreateProgram();
	}

	static ShaderProgram fromVertexFragmentFiles(GL3Renderer renderer, string vertex, string fragment)
	{
		GLShader v = new GLShader();
		v.load(ShaderType.Vertex, std.file.readText(vertex));
		v.compile();

		GLShader f = new GLShader();
		f.load(ShaderType.Fragment, std.file.readText(fragment));
		f.compile();

		return renderer.createShader([v, f]);
	}

	void attach(Shader shader)
	{
		glAttachShader(_program, shader.id);
	}

	void link()
	{
		glLinkProgram(_program);
		bind();
	}

	void bind()
	{
		glUseProgram(_program);
	}

	int registerUniform(string uniform)
	{
		if ((uniform in _properties) !is null)
			return _properties[uniform];
		_properties[uniform] = glGetUniformLocation(_program, uniform.toStringz());
		return _properties[uniform];
	}

	void set(string uniform, int value)
	{
		glUniform1i(_properties[uniform], value);
	}

	void set(string uniform, float value)
	{
		glUniform1f(_properties[uniform], value);
	}

	void set(string uniform, vec2 value)
	{
		glUniform2fv(_properties[uniform], 1, value.value_ptr);
	}

	void set(string uniform, vec3 value)
	{
		glUniform3fv(_properties[uniform], 1, value.value_ptr);
	}

	void set(string uniform, vec4 value)
	{
		glUniform4fv(_properties[uniform], 1, value.value_ptr);
	}

	void set(string uniform, mat2 value)
	{
		glUniformMatrix2fv(_properties[uniform], 1, 1, value.value_ptr);
	}

	void set(string uniform, mat3 value)
	{
		glUniformMatrix3fv(_properties[uniform], 1, 1, value.value_ptr);
	}

	void set(string uniform, mat4 value)
	{
		glUniformMatrix4fv(_properties[uniform], 1, 1, value.value_ptr);
	}

	uint id()
	{
		return _program;
	}
}

class GLShader : Shader
{
private:
	uint _id = 0;
	string _content;

public:
	bool load(ShaderType type, string content)
	{
		_content = content;
		switch (type)
		{
		case ShaderType.Vertex:
			_id = glCreateShader(GL_VERTEX_SHADER);
			break;
		case ShaderType.TessControl:
			_id = glCreateShader(GL_TESS_CONTROL_SHADER);
			break;
		case ShaderType.TessEvaluation:
			_id = glCreateShader(GL_TESS_EVALUATION_SHADER);
			break;
		case ShaderType.Geometry:
			_id = glCreateShader(GL_GEOMETRY_SHADER);
			break;
		case ShaderType.Fragment:
			_id = glCreateShader(GL_FRAGMENT_SHADER);
			break;
		default:
			// TODO: Replace with logger and return false
			throw new Exception("ShaderType " ~ to!string(type) ~ " is not defined!");
		}

		const int len = cast(const(int)) _content.length;

		glShaderSource(_id, 1, [_content.ptr].ptr, &len);
		return true;
	}

	bool compile()
	{
		glCompileShader(_id);
		int success = 0;
		glGetShaderiv(_id, GL_COMPILE_STATUS, &success);

		if (success == 0)
		{
			int logSize = 0;
			glGetShaderiv(_id, GL_INFO_LOG_LENGTH, &logSize);

			char* log = new char[logSize].ptr;
			glGetShaderInfoLog(_id, logSize, &logSize, &log[0]);

			// TODO: Replace with logger and return false
			throw new Exception("Program Output:\n" ~ cast(string) log[0 .. logSize]);
		}
		return true;
	}

	@property uint id()
	{
		return _id;
	}
}
