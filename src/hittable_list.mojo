from ray import *
from memory import ArcPointer
from utils import Variant
from sphere import Sphere

comptime HittableType = Variant[Sphere]


# Mojo doesn't support yet dyn Trait so need to hardcode in Variant
@fieldwise_init
struct AnyHittable(Hittable):
    var hittable: HittableType
    fn hit(self, r: Ray, t_min: Float64, t_max: Float64) -> Optional[HitRecord]:
        if self.hittable.isa[Sphere]():
            return self.hittable[Sphere].hit(r, t_min, t_max)
        return None

    fn __str__(self) -> String:
        if self.hittable.isa[Sphere]():
            return self.hittable[Sphere].__str__()
        return "Unknown Hittable"

    fn write_to[T: Writer](self, mut writer: T):
        writer.write(self.__str__())

struct HittableList(Hittable):
    var objects: List[ArcPointer[AnyHittable]]

    fn __init__(out self):
        self.objects = List[ArcPointer[AnyHittable]]()
    
    fn __init__(out self, object: ArcPointer[AnyHittable]):
        self.objects = List[ArcPointer[AnyHittable]]()
        self.objects.append(object)

    fn add(mut self, object: HittableType):
        self.objects.append(ArcPointer(AnyHittable(object)))

    fn hit(self, read r: Ray, t_min: Float64, t_max: Float64) -> Optional[HitRecord]:
        var hit_record: Optional[HitRecord] = None
        var closest_so_far = t_max

        for o in self.objects:
            maybe_hit = o[].hit(r, t_min, closest_so_far)
            if maybe_hit:
                hit_record = maybe_hit
                closest_so_far: Float64 = hit_record.value().t
        return hit_record

    fn __str__(self) -> String:
        var result = "HittableList with {} objects:\n".format(len(self.objects))
        for o in self.objects:
            result += "  - {}\n".format(o[])
        return result
    
    fn write_to[T: Writer](self, mut writer: T):
        writer.write(self.__str__())