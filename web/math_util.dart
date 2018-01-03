import 'dart:math';

class Point3D {
  double x;
  double y;
  double z;

  Point3D(this.x, this.y, this.z);
}

class Point2D {
  double x;
  double y;

  Point2D(this.x, this.y);
}

class Triangle {
  Point2D a;
  Point2D b;
  Point2D c;

  Triangle(this.a, this.b, this.c);
}

double distance3D(Point3D p1, Point3D p2) {
  double r = 0.0;
  r += pow((p2.x - p1.x), 2);
  r += pow((p2.y - p1.y), 2);
  r += pow((p2.z - p1.z), 2);
  r = sqrt(r);
  return r;
}

double angle2D(Point2D p1, Point2D p2) {
  double r = atan2(
        (p2.y - p1.y),
        (p2.x - p1.x),
      ) *
      180 /
      PI;

  r += 360;
  r %= 360;
  return r;
}

bool isPointInTriangle(Point2D point, Triangle triangle) {
  double as_x = point.x - triangle.a.x;
  double as_y = point.y - triangle.a.y;

  bool s_ab = (triangle.b.x - triangle.a.x) * as_y -
          (triangle.b.y - triangle.a.y) * as_x >
      0;

  if ((triangle.c.x - triangle.a.x) * as_y -
              (triangle.c.y - triangle.a.y) * as_x >
          0 ==
      s_ab) {
    return false;
  }

  if ((triangle.c.x - triangle.b.x) * (point.y - triangle.b.y) -
              (triangle.c.y - triangle.b.y) * (point.x - triangle.b.x) >
          0 !=
      s_ab) {
    return false;
  }

  return true;
}
