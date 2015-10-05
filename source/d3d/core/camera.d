module d3d.core.camera;

import d3d.core;

///
enum ProjectionMode : ubyte
{
	///
	Perspective,
	///
	Orthographic2D,
	///
	Orthographic3D
}

///
class Camera : GameObject
{
private:
	float _near = 0.1f;
	float _far = 100.0f;
	float _width = 1;
	float _height = 1;
	float _aspect = 1;
	float _fov = 45.0f;
	float _iZoom = 1 / 7.0f;
	ProjectionMode _mode = ProjectionMode.Perspective;

	mat4 _projectionMatrix = mat4.perspective(1, 1, 45, 0.1f, 100);
	mat4 _viewMatrix = mat4.identity;
	bool _needUpdate = false;

public:
	///
	@property mat4 projectionMatrix()
	{
		if (_needUpdate)
		{
			if (_mode == ProjectionMode.Perspective)
				_projectionMatrix = mat4.perspective(_width, _height, _fov, _near, _far);
			else if (_mode == ProjectionMode.Orthographic2D)
				_projectionMatrix = mat4.orthographic(0, _width, _height, 0, _near, _far);
			else if (_mode == ProjectionMode.Orthographic3D)
				_projectionMatrix = mat4.orthographic(-_aspect, _aspect, -1, 1, _near, _far) * mat4.identity.scale(_iZoom, _iZoom, _iZoom);
			_needUpdate = false;
		}
		return _projectionMatrix;
	}

	///
	@property mat4 viewMatrix()
	{
		return _viewMatrix = rotationMatrix * translationMatrix;
	}

	///
	@property mat4 rotationMatrix()
	{
		return mat4.identity.rotate(transform.rotation.x, vec3(1, 0, 0)) *
		       mat4.identity.rotate(transform.rotation.y, vec3(0, 1, 0)) *
		       mat4.identity.rotate(transform.rotation.z, vec3(0, 0, 1));
	}

	///
	@property mat4 translationMatrix()
	{
		return mat4.identity.translate(-transform.position.x, -transform.position.y, -transform.position.z);
	}

	///
	@property float nearClip()
	{
		return _near;
	}
	///
	@property float farClip()
	{
		return _far;
	}
	///
	@property float width()
	{
		return _width;
	}
	///
	@property float height()
	{
		return _height;
	}
	///
	@property float fov()
	{
		return _fov;
	}

	/// Zoom for Orthographic3D (Defaults to 7)
	@property float zoom()
	{
		return 1 / _iZoom;
	}

	///
	@property ProjectionMode projectionMode()
	{
		return _mode;
	}

	///
	@property void nearClip(float value)
	{
		// No check on float values
		_needUpdate = true;
		_near = value;
	}
	///
	@property void farClip(float value)
	{
		_needUpdate = true;
		_far = value;
	}
	///
	@property void width(float value)
	{
		_needUpdate = true;
		_width = value;
		_aspect = _width / _height;
	}
	///
	@property void height(float value)
	{
		_needUpdate = true;
		_height = value;
		_aspect = _width / _height;
	}
	///
	@property void fov(float value)
	{
		_needUpdate = true;
		_fov = value;
	}

	/// Zoom for Orthographic3D (Defaults to 7)
	@property void zoom(float value)
	{
		_needUpdate = true;
		_iZoom = 1.0f / value;
	}
	///
	@property void projectionMode(ProjectionMode value)
	{
		_needUpdate = true;
		_mode = value;
	}
}
