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
    var front_face: Bool

    fn __init__(out self, p: Point3, ray: Ray,outward_normal: Vec3, t: Float64):
        self.p = p
        self.t = t
        self.front_face  = ray.dir.dot(outward_normal) < 0
        self.normal = outward_normal if self.front_face else -outward_normal

trait Hittable(Movable & Writable):
    fn hit(self, r: Ray, t_min: Float64, t_max: Float64) -> Optional[HitRecord]:
        ...