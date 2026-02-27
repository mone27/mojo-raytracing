from vec3 import Point3, Vec3

struct Ray:
    var orig: Point3
    var dir: Vec3

    def __init__(out self, origin: Point3, direction: Vec3):
        self.orig = origin
        self.dir = direction
    def __call__(self, t: Float64) -> Point3:
        return self.orig + t * self.dir