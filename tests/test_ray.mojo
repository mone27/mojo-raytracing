from testing import assert_true, assert_almost_equal, assert_false
from vec3 import Vec3, Point3
from ray import Ray, HitRecord


fn assert_vec3_almost_equal(
    actual: Vec3, x: Float64, y: Float64, z: Float64, msg: String = ""
) raises:
    assert_almost_equal(actual.x(), x, msg=msg + " (x)")
    assert_almost_equal(actual.y(), y, msg=msg + " (y)")
    assert_almost_equal(actual.z(), z, msg=msg + " (z)")


def test_ray_init():
    orig = Point3(0.0, 0.0, 0.0)
    dir = Vec3(1.0, 0.0, 0.0)
    r = Ray(orig, dir)
    assert_vec3_almost_equal(r.orig, 0.0, 0.0, 0.0, "ray origin")
    assert_vec3_almost_equal(r.dir, 1.0, 0.0, 0.0, "ray direction")


def test_ray_at():
    orig = Point3(1.0, 2.0, 3.0)
    dir = Vec3(1.0, 1.0, 1.0)
    r = Ray(orig, dir)
    p = r(2.0)
    assert_vec3_almost_equal(p, 3.0, 4.0, 5.0, "ray at t=2")


def test_ray_at_zero():
    orig = Point3(5.0, 5.0, 5.0)
    dir = Vec3(1.0, 0.0, 0.0)
    r = Ray(orig, dir)
    p = r(0.0)
    assert_vec3_almost_equal(p, 5.0, 5.0, 5.0, "ray at t=0 is origin")


def test_hit_record_front_face():
    # Ray going in +z direction hits sphere with outward normal also in +z
    # dot(dir, outward_normal) > 0 means ray is inside → front_face = False
    orig = Point3(0.0, 0.0, -5.0)
    dir = Vec3(0.0, 0.0, 1.0)
    r = Ray(orig, dir)
    outward_normal = Vec3(0.0, 0.0, -1.0)  # normal pointing toward ray origin
    rec = HitRecord(p=Point3(0.0, 0.0, 0.0), ray=r, outward_normal=outward_normal, t=5.0)
    assert_true(rec.front_face, "should be front face when ray hits from outside")
    assert_vec3_almost_equal(rec.normal, 0.0, 0.0, -1.0, "normal unchanged for front face")


def test_hit_record_back_face():
    # Ray going in +z direction hits sphere with outward normal also in +z
    # dot(dir, outward_normal) > 0 → back face (ray inside sphere)
    orig = Point3(0.0, 0.0, -5.0)
    dir = Vec3(0.0, 0.0, 1.0)
    r = Ray(orig, dir)
    outward_normal = Vec3(0.0, 0.0, 1.0)  # same direction as ray
    rec = HitRecord(p=Point3(0.0, 0.0, 0.0), ray=r, outward_normal=outward_normal, t=5.0)
    assert_false(rec.front_face, "should be back face when ray hits from inside")
    assert_vec3_almost_equal(rec.normal, 0.0, 0.0, -1.0, "normal is flipped for back face")


def test_hit_record_t():
    orig = Point3(0.0, 0.0, 0.0)
    dir = Vec3(0.0, 0.0, 1.0)
    r = Ray(orig, dir)
    outward_normal = Vec3(0.0, 0.0, -1.0)
    rec = HitRecord(p=Point3(1.0, 2.0, 3.0), ray=r, outward_normal=outward_normal, t=3.14)
    assert_almost_equal(rec.t, 3.14)
    assert_vec3_almost_equal(rec.p, 1.0, 2.0, 3.0, "hit point")
