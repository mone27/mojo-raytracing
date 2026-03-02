from sys import stderr
from vec3 import Color, write_color, Point3, Vec3
from ray import Ray
from math import sqrt


fn hit_sphere(center: Point3, radius: Float64, r: Ray) -> Float64:
    oc = center - r.orig
    a = r.dir.length_squared()
    h = r.dir.dot(oc)
    c = oc.dot(oc) - radius * radius
    discriminant = h * h - a * c
    if discriminant < 0:
        return -1.0
    else:
        return (h - sqrt(discriminant)) / a

fn ray_color(r: Ray) -> Color:
    t = hit_sphere(Point3(0,0,-1), 0.5, r)
    if t > 0.0:
        N = (r(t) - Point3(0,0,-1)).unit_vector()
        return 0.5 * Color(N.x() + 1, N.y() + 1, N.z() + 1)
    # background    
    unit_direction = r.dir.unit_vector()
    a = 0.5 * (unit_direction.y() + 1.0)
    return (1.0 - a) * Color(1.0, 1.0, 1.0) + a * Color(0.5, 0.7, 1.0)


def main():
    
    aspect_ratio = 16.0 / 9.0
    img_width = 400
    img_height = Int(Float64(img_width) / aspect_ratio)
    img_height = max(1, img_height) # ensure img_height is at least 1

    # Camera
    focal_length = 1.0
    viewport_height = 2.0
    viewport_width = aspect_ratio * viewport_height
    camera_center = Point3(0,0,0)

    viewport_u = Vec3(viewport_width, 0, 0)
    viewport_v = Vec3(0, -viewport_height, 0)

    pixel_delta_u = viewport_u / Float64(img_width)
    pixel_delta_v = viewport_v / Float64(img_height)
    
    viewport_upper_left = camera_center - Vec3(0,0,focal_length) - viewport_u/2 - viewport_v / 2
    pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v)



    with open("image.ppm", "w") as img_file:
        img_file.write("P3\n{} {}\n255\n".format(img_width, img_height))
        for j in range(img_height):
            # print("\rScanlines remaining: {}  ".format(img_height - j), file=stderr)
            for i in range(img_width):
                pixel_center = pixel00_loc + (Float64(i) * pixel_delta_u) + (Float64(j)*pixel_delta_v)
                ray_direction = pixel_center - camera_center
                r = Ray(camera_center, ray_direction)
                pixel_color = ray_color(r)
                write_color(pixel_color, img_file)
    print("\rDone.                 ", file=stderr)
    
    

