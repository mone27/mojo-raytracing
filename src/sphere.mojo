from vec3 import Vec3, Point3
from ray import Hittable, HitRecord, Ray
from math import sqrt

struct Sphere(Hittable & Movable & Copyable):
    var center: Point3
    var radius: Float64

    fn __init__(out self, center: Point3, radius: Float64):
        self.center = center
        self.radius = max(radius, 0.0)
    
    fn hit(self, r: Ray, t_min: Float64, t_max: Float64) -> Optional[HitRecord]:
        oc = self.center - r.orig
        a = r.dir.length_squared()
        h = r.dir.dot(oc)
        c = oc.dot(oc) - self.radius * self.radius
        disc = h * h - a * c
        if disc < 0:
            return None
        sqrt_disc = sqrt(disc)

        # find the nearest root in the range
        root = (h - sqrt_disc) / a
        if root < t_min or root > t_max:
            root = (h + sqrt_disc) / a
            if root < t_min or root > t_max:
                return None
        return HitRecord(
            t=root,
            p=r(root),
            outward_normal=(r(root) - self.center) / self.radius,
            ray=r
        )
    
    fn __str__(self) -> String:
        return "Sphere(center={}, radius={})".format(self.center, self.radius)

    fn write_to[T: Writer](self, mut writer: T):
        writer.write(self.__str__())