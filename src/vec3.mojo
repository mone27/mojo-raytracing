from math import sqrt

struct Vec3(Writable, ImplicitlyCopyable):
    var e: SIMD[DType.float64, 3]

    fn __init__(out self, e1: Float64, e2: Float64, e3: Float64):
        self.e = SIMD[DType.float64, 3](e1, e2, e3)
    
    fn __init__(out self, e: SIMD[DType.float64, 3]):
        self.e = e
    
    fn __init__(out self):
        self.e = SIMD[DType.float64, 3](0.0, 0.0, 0.0)

    fn x(self) -> Float64: return self.e[0]
    fn y(self) -> Float64: return self.e[1]
    fn z(self) -> Float64: return self.e[2]

    fn __neg__(self) -> Self:
        return Self(-self.x(), -self.y(), -self.z())
    fn __getitem__(self, i: Int) -> Float64:
        return self.e[i]
    fn __setitem__(mut self, i: Int, value: Float64):
        self.e[i] = value

    fn __add__(self, other: Self) -> Self:
        return Self(self.e + other.e)
    
    fn __iadd__(mut self, other: Self): self.e += other.e
    
    fn __sub__(self, other: Self) -> Self:
        return Self(self.e - other.e)
    
    fn __isub__(mut self, other: Self): self.e -= other.e
    
    fn __mul__(self, other: Self) -> Self:
        return Self(self.x() * other.x(), self.y() * other.y(), self.z() * other.z())

    fn __mul__(self, t: Float64) -> Self:
        return Self(self.x() * t, self.y() * t, self.z() * t)

    fn __rmul__(self, t: Float64) -> Self:
        return self * t
        
    fn __imul__(mut self, t: Float64): self.e *= t

    fn __truediv__(self, t: Float64) -> Self:
        return Self(self.e/t)
    
    fn __itruediv__(mut self, t: Float64): self.e /= t
    
    fn length_squared(self) -> Float64:
        return self.x() ** 2 + self.y() ** 2 + self.z() ** 2
    
    fn length(self) -> Float64:
        return sqrt(self.length_squared())   

    fn dot(self, other: Self) -> Float64:
        return self.x() * other.x() + self.y() * other.y() + self.z() * other.z()
    
    fn __matmul__(self, other: Self) -> Self:
        return Self(self.y() * other.z() - self.z() * other.y(),
                    self.z() * other.x() - self.x() * other.z(),
                    self.x() * other.y() - self.y() * other.x())
    
    fn cross(self, other: Self) -> Self:
        return self @ other

    fn unit_vector(self) -> Self:
        return self / self.length()

    fn __str__(self) -> String:
        return "{}, {}, {}".format(self.x(), self.y(), self.z())

    fn __repr__(self) -> String:
        return "Vec3({}, {}, {})".format(self.x(), self.y(), self.z())
    fn write_to[T: Writer](self, mut writer: T):
        writer.write(self.__str__())

comptime Point3 = Vec3
comptime Color = Vec3

fn write_color[T: Writer](color: Color, mut writer: T):
    ir = Int(255.999 * color.x())
    ig = Int(255.999 * color.y())
    ib = Int(255.999 * color.z())
    writer.write("{} {} {}\n".format(ir, ig, ib))

