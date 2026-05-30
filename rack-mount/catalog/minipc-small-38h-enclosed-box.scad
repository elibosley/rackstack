use <../enclosed-box/entry.scad>

/*
  Enclosed-box mount for a mini PC measured at:
  38h x 114w x 106d mm.

  The mount adds 2 mm total clearance on each axis:
  40h x 116w x 108d mm.

  Use with the minipc-stack rack profile:
    python3 rbuild.py -b all -c minipc-stack
*/

enclosedBoxSystem(
    zOrientation = "middle",
    recessSideRail = false,
    boxWidth = 116,
    boxHeight = 40,
    boxDepth = 108,
    railDefaultThickness = 1.5,
    railSideThickness = 3,
    frontPlateThickness = 3,
    frontPlateCutoutYSpace = 4,
    frontPlateCutoutXSpace = 7
);
