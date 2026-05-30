use <../tray/tray.scad>

/*
  120 mm fan tray adapted for the minipc-stack profiles.

  This mounts a 120 mm case fan horizontally inside the rack. Use it when you
  want airflow up/down through the stack.
*/

trayWidth = 130;
trayDepth = 130;
fanHoleOffset = 12.5;
fanHoleSpacing = 105;
fanCenter = trayWidth / 2;

difference() {
    bottomScrewTray(
        u = 2,
        trayWidth = trayWidth,
        trayDepth = trayDepth,
        trayThickness = 3,
        frontLipHeight = 8,
        backLipHeight = 8,
        mountPoints = [
            [fanHoleOffset, fanHoleOffset],
            [fanHoleOffset + fanHoleSpacing, fanHoleOffset],
            [fanHoleOffset, fanHoleOffset + fanHoleSpacing],
            [fanHoleOffset + fanHoleSpacing, fanHoleOffset + fanHoleSpacing],
        ],
        frontThickness = 3,
        sideThickness = 3,
        mountPointElevation = 1,
        mountPointType = "m4",
        sideSupport = true,
        trayLeftPadding = 7.5
    );

    translate(v = [fanCenter, fanCenter, -5])
    cylinder(h = 16, r = 57, $fn = 96);
}
