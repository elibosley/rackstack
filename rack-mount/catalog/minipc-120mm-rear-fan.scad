use <../tray/tray.scad>

/*
  120 mm rear fan mount adapted for the minipc-stack-tall profile.

  This mounts a 120 mm fan vertically at the rear, with the fan body outside
  the rack. It needs a tall rack profile; use minipc-stack-tall.
*/

difference() {
    bottomScrewTray(
        u = 12,
        trayWidth = 130,
        trayDepth = 35,
        trayThickness = 3,
        frontLipHeight = 126,
        backLipHeight = 126,
        mountPoints = [],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m4",
        sideSupport = true,
        trayLeftPadding = 7.5
    );

    translate(v = [-5, 10, -5])
    rotate(a = [90, 0, 0]) {
        translate(v = [67.5, 67.5, -25])
        rotate(a = [90, 0, 0])
        rotate(a = [0, 90, 90])
        cylinder(h = 60, r = 60, $fn = 96);

        for (p = [[15, 15], [120, 15], [120, 120], [15, 120]]) {
            translate(v = [p[0], p[1], -25])
            rotate(a = [90, 0, 0])
            rotate(a = [0, 90, 90])
            cylinder(h = 65, r = 2.5, $fn = 32);
        }
    }
}
