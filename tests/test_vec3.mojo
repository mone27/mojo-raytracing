from testing import assert_true, assert_equal, assert_almost_equal
from vec3 import Vec3, Point3, Color, write_color


fn assert_vec3_almost_equal(
    actual: Vec3, x: Float64, y: Float64, z: Float64, msg: String = ""
) raises:
    assert_almost_equal(actual.x(), x, msg=msg + " (x)")
    assert_almost_equal(actual.y(), y, msg=msg + " (y)")
    assert_almost_equal(actual.z(), z, msg=msg + " (z)")


def test_vec3_default_init():
    v = Vec3()
    assert_almost_equal(v.x(), 0.0)
    assert_almost_equal(v.y(), 0.0)
    assert_almost_equal(v.z(), 0.0)


def test_vec3_init():
    v = Vec3(1.0, 2.0, 3.0)
    assert_almost_equal(v.x(), 1.0)
    assert_almost_equal(v.y(), 2.0)
    assert_almost_equal(v.z(), 3.0)


def test_vec3_negation():
    v = Vec3(1.0, -2.0, 3.0)
    neg = -v
    assert_vec3_almost_equal(neg, -1.0, 2.0, -3.0, "negation")


def test_vec3_getitem():
    v = Vec3(4.0, 5.0, 6.0)
    assert_almost_equal(v[0], 4.0)
    assert_almost_equal(v[1], 5.0)
    assert_almost_equal(v[2], 6.0)


def test_vec3_add():
    a = Vec3(1.0, 2.0, 3.0)
    b = Vec3(4.0, 5.0, 6.0)
    c = a + b
    assert_vec3_almost_equal(c, 5.0, 7.0, 9.0, "add")


def test_vec3_iadd():
    a = Vec3(1.0, 2.0, 3.0)
    a += Vec3(1.0, 1.0, 1.0)
    assert_vec3_almost_equal(a, 2.0, 3.0, 4.0, "iadd")


def test_vec3_sub():
    a = Vec3(5.0, 7.0, 9.0)
    b = Vec3(1.0, 2.0, 3.0)
    c = a - b
    assert_vec3_almost_equal(c, 4.0, 5.0, 6.0, "sub")


def test_vec3_mul_scalar():
    v = Vec3(1.0, 2.0, 3.0)
    r = v * 2.0
    assert_vec3_almost_equal(r, 2.0, 4.0, 6.0, "mul scalar")


def test_vec3_rmul_scalar():
    v = Vec3(1.0, 2.0, 3.0)
    r = 3.0 * v
    assert_vec3_almost_equal(r, 3.0, 6.0, 9.0, "rmul scalar")


def test_vec3_mul_elementwise():
    a = Vec3(2.0, 3.0, 4.0)
    b = Vec3(5.0, 6.0, 7.0)
    c = a * b
    assert_vec3_almost_equal(c, 10.0, 18.0, 28.0, "mul elementwise")


def test_vec3_div():
    v = Vec3(2.0, 4.0, 6.0)
    r = v / 2.0
    assert_vec3_almost_equal(r, 1.0, 2.0, 3.0, "div")


def test_vec3_length_squared():
    v = Vec3(1.0, 2.0, 2.0)
    assert_almost_equal(v.length_squared(), 9.0)


def test_vec3_length():
    v = Vec3(1.0, 2.0, 2.0)
    assert_almost_equal(v.length(), 3.0)


def test_vec3_dot():
    a = Vec3(1.0, 2.0, 3.0)
    b = Vec3(4.0, 5.0, 6.0)
    assert_almost_equal(a.dot(b), 32.0)


def test_vec3_cross():
    a = Vec3(1.0, 0.0, 0.0)
    b = Vec3(0.0, 1.0, 0.0)
    c = a.cross(b)
    assert_vec3_almost_equal(c, 0.0, 0.0, 1.0, "cross product")


def test_vec3_unit_vector():
    v = Vec3(3.0, 0.0, 0.0)
    u = v.unit_vector()
    assert_almost_equal(u.length(), 1.0)
    assert_almost_equal(u.x(), 1.0)


def test_vec3_str():
    v = Vec3(1.0, 2.0, 3.0)
    assert_equal(str(v), "1.0, 2.0, 3.0")


def test_point3_is_vec3():
    p = Point3(1.0, 2.0, 3.0)
    assert_almost_equal(p.x(), 1.0)
    assert_almost_equal(p.y(), 2.0)
    assert_almost_equal(p.z(), 3.0)


def test_color_is_vec3():
    c = Color(0.5, 0.25, 0.75)
    assert_almost_equal(c.x(), 0.5)
    assert_almost_equal(c.y(), 0.25)
    assert_almost_equal(c.z(), 0.75)


def test_write_color():
    c = Color(1.0, 0.0, 0.5)
    out = String()
    write_color(c, out)
    assert_equal(out, "255 0 127\n")
