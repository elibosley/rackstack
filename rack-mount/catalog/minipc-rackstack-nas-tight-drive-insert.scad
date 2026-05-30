include <../../helper/common.scad>
include <../common.scad>
use <../rackEars.scad>
use <./third_party/agentscad_drive35_sff8301.scad>

/*
  Tight two-HDD insert for the already-printed minipc-stack rack.

  This is the only Rackstack NAS model in this folder now. It is a front/back
  rack-mount appliance insert: front and rear printed brackets screw directly
  to the two 3.5 in drives. The drives act as the structural span, which keeps
  the assembly open for airflow and lets the front bracket + drives slide into
  the rack before the rear bracket is added.

  Use with:
    openscad -D 'profileName="minipc-stack"' -D 'part="front"' ...
    openscad -D 'profileName="minipc-stack"' -D 'part="rear"' ...
*/

part = "assembly"; // [assembly, front, rear]

minipcRackstackTightDriveInsert(part=part);

hddL = drive35_length();
hddW = drive35_width();
hddH = drive35_height_common();

insertU = 5;
bodyW = maxUnitWidth;
bodyD = maxUnitDepth;
bodyX0 = railScrewHoleToInnerEdge;
bodyX1 = bodyX0 + bodyW;

mountX0 = -rackMountScrewXDist;
mountW = rackMountScrewWidth + 2*rackMountScrewXDist;
mountFlangeT = 3;
mountYFront = 0;
mountYRear = bodyD - mountFlangeT;

plateT = 1.4;
driveClearanceZ = 0.4;
driveGap = plateT + driveClearanceZ;
driveLeftOverhang = 2.0;
driveBackClear = 7;
driveX0 = bodyX0 - driveLeftOverhang;
driveY0 = bodyD - hddW - driveBackClear;
driveZ0 = plateT + driveClearanceZ;

finT = 2.4;
finH = hddH;
driveScrewSlotL = 8;
driveScrewR = drive35_thread_clearance_radius(0.45);
connectorReliefX = 32;
connectorReliefYMargin = 8;
connectorReliefZMargin = 3;
frontTopBeamD = 3.8;
frontTopBeamH = 5.0;

wingH = insertU*uDiff + 2*rackMountScrewZDist;
wingR = 1.5;
standardEarSideT = 3;
standardEarW = rackMountScrewXDist + railScrewHoleToInnerEdge + standardEarSideT;
frontEarDepth = driveY0;
rearEarDepth = bodyD - (driveY0 + hddW);

module minipcRackstackTightDriveInsert(part="assembly") {
  if (part == "front") {
    frontDriveCarrier();
  } else if (part == "rear") {
    rearRackSupport();
  } else {
    assembledDriveInsert();
  }
}

module assembledDriveInsert() {
  frontDriveBracket();
  color([0.33, 0.42, 0.40])
  rearDriveBracket();
}

module frontDriveCarrier() {
  frontDriveBracket();
}

module rearRackSupport() {
  rearDriveBracket();
}

module frontDriveBracket() {
  difference() {
    union() {
      rackStackEarPair(side="front");
      driveSideRails(side="front");
      frontBracketReinforcement();
    }

    driveSideMountSlotsForBracket(side="front");
  }
}

module rearDriveBracket() {
  difference() {
    union() {
      rackStackEarPair(side="rear");
      driveSideRails(side="rear");
    }

    driveSideMountSlotsForBracket(side="rear");
  }
}

module minipcRackstackTightDriveInsertPreview() {
  color([0.25, 0.31, 0.30])
  frontDriveBracket();

  color([0.33, 0.42, 0.40])
  rearDriveBracket();

  for (i = [0:1]) {
    translate(v=[driveX0, driveY0, driveBottomZ(i)])
    drive35_reference_model();
  }
}

module shelfAt(z) {
  translate(v=[bodyX0, 0, z])
  roundedPlateXY(width=bodyW, depth=bodyD, height=plateT, r=1.2);
}

module rackWingsAt(ys, z0, height) {
  for (y = ys) {
    translate(v=[mountX0, y, z0])
    roundedPanelXz(width=rackEarW, thickness=mountFlangeT, height=height, r=wingR);

    translate(v=[bodyX1, y, z0])
    roundedPanelXz(width=rackEarW, thickness=mountFlangeT, height=height, r=wingR);
  }
}

module rackStackEarPair(side) {
  sideDepth = side == "front" ? frontEarDepth : rearEarDepth;

  if (side == "front") {
    rackStackEarLeft(y=0, sideDepth=sideDepth, mirrorY=false);
    rackStackEarRight(y=0, sideDepth=sideDepth, mirrorY=false);
  } else {
    rackStackEarLeft(y=bodyD, sideDepth=sideDepth, mirrorY=true);
    rackStackEarRight(y=bodyD, sideDepth=sideDepth, mirrorY=true);
  }
}

module rackStackEarLeft(y, sideDepth, mirrorY) {
  translate(v=[0, y, rackMountScrewZDist])
  if (mirrorY) {
    mirror(v=[0, 1, 0])
    rackStackStandardEar(sideDepth=sideDepth);
  } else {
    rackStackStandardEar(sideDepth=sideDepth);
  }
}

module rackStackEarRight(y, sideDepth, mirrorY) {
  translate(v=[rackMountScrewWidth, y, rackMountScrewZDist])
  mirror(v=[1, 0, 0])
  if (mirrorY) {
    mirror(v=[0, 1, 0])
    rackStackStandardEar(sideDepth=sideDepth);
  } else {
    rackStackStandardEar(sideDepth=sideDepth);
  }
}

module rackStackStandardEar(sideDepth) {
  rackEarModule(
    u=insertU,
    frontThickness=mountFlangeT,
    sideThickness=standardEarSideT,
    frontWidth=standardEarW,
    sideDepth=sideDepth,
    backPlaneHeight=wingH,
    support=true
  );
}

module driveSideRails(side) {
  y = side == "front" ? driveY0 - finT : driveY0 + hddW;

  translate(v=[bodyX0, y, driveStackZ0()])
  roundedPanelXz(width=bodyW, thickness=finT, height=driveStackH(), r=0.8);
}

module frontBracketReinforcement() {
  frontRailTopBeams();
}

module frontRailTopBeams() {
  for (i = [0:1]) {
    frontRailTopBeamForDrive(i=i);
  }
}

module frontRailTopBeamForDrive(i) {
  y = driveY0 - finT - frontTopBeamD;
  z = driveBottomZ(i) + finH - frontTopBeamH;

  // One continuous top beam reinforces the front rail away from the side-hole
  // line, which is near the lower quarter of a 3.5 in HDD.
  translate(v=[bodyX0, y, z])
  roundedPlateXY(width=bodyW, depth=finT + frontTopBeamD, height=frontTopBeamH, r=0.9);
}

module driveSideRailForDrive(i, side) {
  z = driveBottomZ(i);
  y = side == "front" ? driveY0 - finT : driveY0 + hddW;

  translate(v=[bodyX0, y, z])
  roundedPanelXz(width=bodyW, thickness=finT, height=finH, r=0.8);
}

module driveSideMountSlotsForBracket(side) {
  for (i = [0:1]) {
    driveSideMountSlotsForDrive(i=i, side=side);
  }
}

module driveSideMountSlotsForDrive(i, side) {
  z = driveBottomZ(i) + drive35_side_hole_center_height_from_bottom();
  y = side == "front" ? driveY0 - finT/2 : driveY0 + hddW + finT/2;
  slotDepth = finT + 4;

  for (x = drive35_side_hole_x_positions()) {
    translate(v=[driveX0 + x, y, z])
    slotThroughY(length=driveScrewSlotL, r=driveScrewR, depth=slotDepth);
  }
}

module frontRackMountHoles() {
  rackMountHolesAtY(mountFlangeT/2);
}

module rearRackMountHoles() {
  rackMountHolesAtY(bodyD - mountFlangeT/2);
}

module rackMountHolesAtY(y) {
  for (x = [0, rackMountScrewWidth]) {
    for (z = rackMountZs()) {
      translate(v=[x, y, z])
      rotate(a=[90, 0, 0])
      cylinder(r=screwRadiusSlacked(mainRailScrewType), h=mountFlangeT + 2, center=true, $fn=32);
    }
  }
}

module connectorReliefWindows() {
  x0 = driveX0 + hddL - connectorReliefX;
  w = connectorReliefX + driveLeftOverhang + 6;

  for (i = [0:1]) {
    z0 = driveBottomZ(i) + connectorReliefZMargin;
    zH = hddH - 2*connectorReliefZMargin;

    translate(v=[x0, driveY0 + connectorReliefYMargin, z0])
    cube(size=[w, hddW - 2*connectorReliefYMargin, zH]);

    translate(v=[x0, driveY0 - finT - 1, z0])
    cube(size=[w, finT + 2, zH]);

    translate(v=[x0, driveY0 + hddW - 1, z0])
    cube(size=[w, finT + 2, zH]);
  }
}

module shelfAirSlotsForZs(zs) {
  for (z = zs) {
    for (x = [driveX0 + 18:21:driveX0 + hddL - 18]) {
      translate(v=[x, driveY0 + hddW/2, z - 0.1])
      roundedSlotXY(length=hddW - 22, width=7, height=plateT + 0.2);
    }
  }
}

function driveBottomZ(i) = driveZ0 + i*(hddH + driveGap);
function driveStackZ0() = driveBottomZ(0);
function driveStackH() = topPlateZ() - driveStackZ0();
function middlePlateZ() = driveBottomZ(0) + hddH;
function topPlateZ() = driveBottomZ(1) + hddH;
function shelfZs() = [0, middlePlateZ(), topPlateZ()];
function rackMountZs() = [
  for (i = [0:insertU])
  rackMountScrewZDist + i*uDiff
];
function driveSideScrewXGlobals() = [
  for (x = drive35_side_hole_x_positions())
  driveX0 + x
];

module roundedPlateXY(width, depth, height, r) {
  safeR = min(r, min(width, depth)/2 - eps);

  hull() {
    translate(v=[safeR, safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);

    translate(v=[width - safeR, safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);

    translate(v=[safeR, depth - safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);

    translate(v=[width - safeR, depth - safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);
  }
}

module roundedPanelXz(width, thickness, height, r) {
  safeR = min(r, min(width, height)/2 - eps);

  hull() {
    translate(v=[safeR, 0, safeR])
    rotate(a=[-90, 0, 0])
    cylinder(r=safeR, h=thickness, $fn=32);

    translate(v=[width - safeR, 0, safeR])
    rotate(a=[-90, 0, 0])
    cylinder(r=safeR, h=thickness, $fn=32);

    translate(v=[safeR, 0, height - safeR])
    rotate(a=[-90, 0, 0])
    cylinder(r=safeR, h=thickness, $fn=32);

    translate(v=[width - safeR, 0, height - safeR])
    rotate(a=[-90, 0, 0])
    cylinder(r=safeR, h=thickness, $fn=32);
  }
}

module roundedSlotXY(length, width, height) {
  r = width/2;

  hull() {
    translate(v=[0, -length/2 + r, 0])
    cylinder(r=r, h=height, $fn=24);

    translate(v=[0, length/2 - r, 0])
    cylinder(r=r, h=height, $fn=24);
  }
}

module slotThroughY(length, r, depth) {
  hull() {
    translate(v=[-length/2 + r, 0, 0])
    rotate(a=[90, 0, 0])
    cylinder(r=r, h=depth, center=true, $fn=32);

    translate(v=[length/2 - r, 0, 0])
    rotate(a=[90, 0, 0])
    cylinder(r=r, h=depth, center=true, $fn=32);
  }
}

module triangularGussetYZ(width, depth, height) {
  polyhedron(
    points=[
      [0, 0, 0],
      [width, 0, 0],
      [0, depth, 0],
      [width, depth, 0],
      [0, 0, height],
      [width, 0, height]
    ],
    faces=[
      [0, 2, 3, 1],
      [0, 1, 5, 4],
      [2, 4, 5, 3],
      [0, 4, 2],
      [1, 3, 5]
    ]
  );
}
