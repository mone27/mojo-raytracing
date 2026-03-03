from testing import assert_true, assert_false, assert_almost_equal
from vec3 import Vec3, Point3
from ray import Ray, HitRecord
from sphere import Sphere


fn assert_vec3_almost_equal(
    actual: Vec3, x: Float64, y: Float64, z: Float64, msg: String = ""
) raises:
    assert_almost_equal(actual.x(), x, msg=msg + " (x)")
    assert_almost_equal(actual.y(), y, msg=msg + " (y)")
    assert_almost_equal(actual.z(), z, msg=msg + " (z)")


def test_sphere_init():
    s = Sphere(Point3(1.0, 2.0, 3.0), 5.0)
    assert_vec3_almost_equal(s.center, 1.0, 2.0, 3.0, "sphere center")
    assert_almost_equal(s.radius, 5.0, msg="sphere radius")


def test_sphere_clamps_negative_radius():
    s = Sphere(Point3(0.0, 0.0, 0.0), -1.0)
    assert_almost_equal(s.radius, 0.0, msg="negative radius clamped to 0")


def test_sphere_hit_center():
    # Ray shooting straight at a sphere centered at (0, 0, -1) with radius 0.5
    s = Sphere(Point3(0.0, 0.0, -1.0), 0.5)
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(0.0, 0.0, -1.0))
    maybe_hit = s.hit(r, 0.001, Float64.MAX)
    assert_true(bool(maybe_hit), "ray should hit sphere")
    rec = maybe_hit.value()
    assert_almost_equal(rec.t, 0.5, msg="hit at t=0.5 (front of sphere)")


def test_sphere_hit_miss():
    # Ray going in x direction, sphere is in -z, should miss
    s = Sphere(Point3(0.0, 0.0, -1.0), 0.5)
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(1.0, 0.0, 0.0))
    maybe_hit = s.hit(r, 0.001, Float64.MAX)
    assert_false(bool(maybe_hit), "ray should miss sphere")


def test_sphere_hit_outside_t_range():
    # Ray pointing towards sphere but t_max is too small
    s = Sphere(Point3(0.0, 0.0, -1.0), 0.5)
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(0.0, 0.0, -1.0))
    maybe_hit = s.hit(r, 0.001, 0.1)
    assert_false(bool(maybe_hit), "hit outside t range should return None")


def test_sphere_hit_normal_points_outward():
    s = Sphere(Point3(0.0, 0.0, -1.0), 0.5)
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(0.0, 0.0, -1.0))
    maybe_hit = s.hit(r, 0.001, Float64.MAX)
    assert_true(bool(maybe_hit), "ray should hit sphere")
    rec = maybe_hit.value()
    # front face, normal should point toward viewer (z > 0)
    assert_true(rec.front_face, "should be front face")
    assert_almost_equal(rec.normal.z(), 1.0, msg="normal z should be +1")


def test_sphere_str():
    s = Sphere(Point3(0.0, 1.0, 2.0), 3.0)
    assert_true(str(s).__contains__("Sphere"), "str should contain Sphere")
