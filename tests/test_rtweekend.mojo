from testing import assert_almost_equal
from math import pi
from rtweekend import degrees_to_radians


def test_degrees_to_radians_zero():
    assert_almost_equal(degrees_to_radians(0.0), 0.0)


def test_degrees_to_radians_180():
    assert_almost_equal(degrees_to_radians(180.0), pi)


def test_degrees_to_radians_360():
    assert_almost_equal(degrees_to_radians(360.0), 2.0 * pi)


def test_degrees_to_radians_90():
    assert_almost_equal(degrees_to_radians(90.0), pi / 2.0)


def test_degrees_to_radians_45():
    assert_almost_equal(degrees_to_radians(45.0), pi / 4.0)
