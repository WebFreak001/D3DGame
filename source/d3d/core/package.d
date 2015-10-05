/// Core package containing just math and interfaces. No platform specific things are here.
/// Use `d3d.common`, `d3d.desktop` and `d3d.sdl*` for a SDL implementation.

module d3d.core;

public:
import gl3n.aabb;
import gl3n.frustum;
import gl3n.interpolate;
import gl3n.linalg;
import gl3n.math;
import gl3n.plane;
import gl3n.util;

import d3d.core.component.icomponent;

import d3d.core.render.context;
import d3d.core.render.guirenderer;
import d3d.core.render.irenderer;
import d3d.core.render.itexture;
import d3d.core.render.material;
import d3d.core.render.mesh;
import d3d.core.render.shader;

import d3d.core.bitmap;
import d3d.core.camera;
import d3d.core.color;
import d3d.core.context;
import d3d.core.event;
import d3d.core.extcom;
import d3d.core.gameobject;
import d3d.core.icontentext;
import d3d.core.iview;
import d3d.core.transform;

alias u32vec2 = Vector!(uint, 2);
alias i32vec2 = Vector!(int, 2);
