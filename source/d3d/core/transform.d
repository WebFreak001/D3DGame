module d3d.core.transform;

import d3d.core;

import std.format;

struct Transform
{
private:
	vec3 _position = vec3(0), _rotation = vec3(0), _scale = vec3(1);
	Transform* _parent;

public:
	@property mat4 transform()
	{
		return (_parent ? _parent.transform : mat4.identity) * (mat4.translation(_position.x, _position.y, _position.z))
		       * (mat4.identity.rotatez(-_rotation.z) * mat4.identity.rotatey(-_rotation.y) * mat4.identity.rotatex(-_rotation.x))
		       * mat4.identity.scale(_scale.x, _scale.y, _scale.z);
	}

	string toString()
	{
		if (_parent)
			return format("[P: %s, R: %s, S: %s, Parent: %s]", position, rotation, scale, _parent.toString());
		else
			return format("[P: %s, R: %s, S: %s]", position, rotation, scale);
	}

	@property vec3 appliedPosition()
	{
		return (transform * vec4(0, 0, 0, 1)).xyz;
	}

	void setIdentity()
	{
		_position = vec3(0);
		_rotation = vec3(0);
		_scale = vec3(1);
	}

	@property ref vec3 position()
	{
		return _position;
	}

	@property ref vec3 rotation()
	{
		return _rotation;
	}

	@property ref vec3 scale()
	{
		return _scale;
	}

	@property ref Transform* parent()
	{
		return _parent;
	}
}

unittest
{
	bool aboutEqual(T)(T a, T b)
	{
		static if (is (T == float))
			return std.math.abs(a - b) < 0.001f;
		else
			return (a - b).length_squared < 0.1f;
	}

	Transform transform;
	assert(transform.appliedPosition == vec3(0), "Invalid matrix");

	transform.position = vec3(3, 2, 0);
	assert((transform.transform * vec4(1, 0, 1, 1)).xyz == vec3(4, 2, 1), "Invalid matrix");

	Transform parent;
	transform.parent = &parent;

	parent.position = vec3(1, 0, 0);

	assert((transform.transform * vec4(1, 0, 1, 1)).xyz == vec3(5, 2, 1), "Invalid parent offset");

	parent.rotation = vec3(0, 0, 1.57079633);

	assert(aboutEqual(transform.appliedPosition, vec3(3, -3, 0)), "Invalid parent rotation");
}
