from sys import stderr, stdout
from vec3 import Color, write_color

def main():
    img_width = 256
    img_height = 256
    var stdout = stdout
    print("P3\n{} {}\n255".format(img_width, img_height))
    for j in range(img_height):
        print("\rScanlines remaining: {}  ".format(img_height - j), file=stderr)
        for i in range(img_width):
            pixel_color = Color(
                Float64(i)/Float64(img_width),
                Float64(j)/Float64(img_height),
                0.)
            write_color(pixel_color, stdout)
    print("\rDone.                 ", file=stderr)


fn camera():
    aspect_ratio = 16.0 / 9.0
    img_width = 400
    img_height = Int(Float64(img_width) / aspect_ratio)
    img_height = max(1, img_height) # ensure img_height is at least 1
    viewport_height = 2.0
    viewport_width = aspect_ratio * viewport_height

    
    
