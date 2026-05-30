include <../../config/common.scad>
include <../../helper/common.scad>
include <../../rack/sharedVariables.scad>

/*
  Side-mounted 92 mm fan plate for minipc-stack profiles.

  Standard 92 mm fan hole spacing is 82.5 mm. This plate mounts a fan on the
  outside of the rack side and uses M4 rail screws to attach to the front rails.
*/

plateThickness = 3;
plateWidth = 98;
plateHeight = 98;
fanOpeningR = 42;
fanHoleSpacing = 82.5;
fanHoleR = 2.3;
railMountHoleR = screwRadiusSlacked(mainRailScrewType);

difference() {
    union() {
        translate(v = [-plateWidth / 2, -plateHeight / 2, 0])
        minkowski() {
            cube(size = [plateWidth - 6, plateHeight - 6, plateThickness]);
            cylinder(r = 3, h = eps, $fn = 32);
        }

        // Small rail tabs so the plate can be attached to rack mount holes.
        translate(v = [-rackMountScrewWidth / 2 - 4, -plateHeight / 2, 0])
        cube(size = [8, plateHeight, plateThickness]);

        translate(v = [rackMountScrewWidth / 2 - 4, -plateHeight / 2, 0])
        cube(size = [8, plateHeight, plateThickness]);
    }

    cylinder(r = fanOpeningR, h = 10, center = true, $fn = 96);

    for (x = [-fanHoleSpacing / 2, fanHoleSpacing / 2]) {
        for (y = [-fanHoleSpacing / 2, fanHoleSpacing / 2]) {
            translate(v = [x, y, -5])
            cylinder(r = fanHoleR, h = 12, $fn = 32);
        }
    }

    for (x = [-rackMountScrewWidth / 2, rackMountScrewWidth / 2]) {
        for (y = [-40, 40]) {
            translate(v = [x, y, -5])
            cylinder(r = railMountHoleR, h = 12, $fn = 32);
        }
    }
}
