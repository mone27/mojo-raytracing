from testing import assert_true, assert_false, assert_almost_equal
from vec3 import Vec3, Point3
from ray import Ray
from sphere import Sphere
from hittable_list import HittableList, HittableType


def test_hittable_list_empty():
    world = HittableList()
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(0.0, 0.0, -1.0))
    result = world.hit(r, 0.001, Float64.MAX)
    assert_false(bool(result), "empty list should not hit")


def test_hittable_list_single_sphere_hit():
    world = HittableList()
    world.add(HittableType(Sphere(Point3(0.0, 0.0, -1.0), 0.5)))
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(0.0, 0.0, -1.0))
    result = world.hit(r, 0.001, Float64.MAX)
    assert_true(bool(result), "should hit the sphere")
    assert_almost_equal(result.value().t, 0.5, msg="hit at t=0.5")


def test_hittable_list_single_sphere_miss():
    world = HittableList()
    world.add(HittableType(Sphere(Point3(0.0, 0.0, -1.0), 0.5)))
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(1.0, 0.0, 0.0))
    result = world.hit(r, 0.001, Float64.MAX)
    assert_false(bool(result), "ray in x direction should miss sphere in -z")


def test_hittable_list_two_spheres_nearest_hit():
    world = HittableList()
    # Closer sphere at z=-1, farther sphere at z=-3
    world.add(HittableType(Sphere(Point3(0.0, 0.0, -1.0), 0.5)))
    world.add(HittableType(Sphere(Point3(0.0, 0.0, -3.0), 0.5)))
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(0.0, 0.0, -1.0))
    result = world.hit(r, 0.001, Float64.MAX)
    assert_true(bool(result), "should hit a sphere")
    # Should return the closer hit (t ≈ 0.5, front of sphere at z=-1)
    assert_almost_equal(result.value().t, 0.5, msg="should return closer sphere hit")


def test_hittable_list_from_single_sphere():
    from memory import ArcPointer
    from hittable_list import AnyHittable
    sphere = ArcPointer(AnyHittable(HittableType(Sphere(Point3(0.0, 0.0, -1.0), 0.5))))
    world = HittableList(sphere)
    r = Ray(Point3(0.0, 0.0, 0.0), Vec3(0.0, 0.0, -1.0))
    result = world.hit(r, 0.001, Float64.MAX)
    assert_true(bool(result), "should hit the sphere")
