from math import pi

from sys import stderr
from vec3 import Color, write_color, Point3, Vec3
from ray import Ray
from math import sqrt
from hittable_list import HittableList, AnyHittable, HittableType
from memory import ArcPointer
from sphere import Sphere

fn degrees_to_radians(degrees: Float64) -> Float64:
    return degrees * pi / 180.0
