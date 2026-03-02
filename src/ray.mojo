from vec3 import Point3, Vec3

struct Ray:
    var orig: Point3
    var dir: Vec3

    fn __init__(out self, origin: Point3, direction: Vec3):
        self.orig = origin
        self.dir = direction
    fn __call__(self, t: Float64) -> Point3:
        return self.orig + t * self.dir

@fieldwise_init
struct HitRecord(Copyable):
    var p: Point3
    var normal: Vec3
    var t: Float64

trait Hittable:
    fn hit(self, r: Ray, t_min: Float64, t_max: Float64) -> Optional[HitRecord]:
        ...