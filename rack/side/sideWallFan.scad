include <./sideWallLeft.scad>
include <./sideWallRight.scad>

/*
  Side wall variants with a 92 mm fan cutout.

  Standard 92 mm fan hole spacing is 82.5 mm.
*/

fanOpeningR = 42;
fanHoleSpacing = 82.5;
fanHoleR = 2.3;
fanCenterY = sideWallY / 2;
fanCenterZ = sideWallZ / 2;

module sideWallFanLeft() {
  difference() {
    sideWallLeft();
    sideFanCutout();
  }
}

module sideWallFanRight() {
  difference() {
    sideWallRight();
    mirror(v=[1,0,0])
    sideFanCutout();
  }
}

module sideFanCutout() {
  translate(v = [-inf / 2, fanCenterY, fanCenterZ])
  rotate(a = [0, 90, 0])
  cylinder(r = fanOpeningR, h = inf, $fn = 96);

  for (y = [-fanHoleSpacing / 2, fanHoleSpacing / 2]) {
    for (z = [-fanHoleSpacing / 2, fanHoleSpacing / 2]) {
      translate(v = [-inf / 2, fanCenterY + y, fanCenterZ + z])
      rotate(a = [0, 90, 0])
      cylinder(r = fanHoleR, h = inf, $fn = 32);
    }
  }
}
