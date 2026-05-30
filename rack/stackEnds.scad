include <../helper/common.scad>
include <./sharedVariables.scad>
include <./connector/connectors.scad>

module rackJoiner() {
  translate(v=[0,0,stackConnectorDualSpacing/2])
  stackConnectorPlug();

  mirror(v=[0,0,1])
  translate(v=[0,0,stackConnectorDualSpacing/2])
  stackConnectorPlug();

  translate(v=[0,0,-stackConnectorDualSpacing/2])
  cube(size=[connectorRectWidth+connectorRectPlugSlack, connectorRectDepth+connectorRectPlugSlack, stackConnectorDualSpacing]);
}

module rackFeet() {

  bandThickness = 2;
  height = 18;

  translate(v = [stackConnectorDx/2, 0, 2])
  mirror(v=[0,0,1]) {
    // stack connectors along rack x axis
    translate(v = [-(stackConnectorDx+connectorRectWidth)/2, -connectorRectDepth/2, 2-overhangSlack])
    mirror(v = [0, 0, 1]) {
      translate(v = [stackConnectorDx, 0, 0])
      stackConnectorBottom();

      stackConnectorBottom();
    }
    band();
  }

  module band() {
    intersection() {
      translate(v=[0,0,2])
      difference() {
        roundedCube(rackTotalWidth, inf50, height, 5, center = true);

        translate(v=[0,0,3])
        roundedCube(rackTotalWidth-6, inf50, height-6, 3, center = true);
      }

      halfspace(vpos=[0,1,-tan(feetProtrusionAngle)],p=[0,-8,2]);
      halfspace(vpos=[0,-1, tan(feetProtrusionAngle)],p=[0,6,2]);

      // TODO make these edge deburrings more parametric
      halfspace(vpos=[0,-1,0],p=[0,16,2]);
      halfspace(vpos=[0,1,0],p=[0,-5,2]);
    }

  }

  module roundedCube(x,y,z,r, center=false) {
    translate(v=[0,0,z/2])
    minkowski() {
      cube(size=[x-2*r,y,z-2*r], center=center);

      rotate(a=[90,0,0])
      cylinder(r=r, h=eps);
    }
  }
}

module rackSideFeet() {

  height = 18;

  translate(v = [0, -rackTotalDepth/2, 2])
  mirror(v=[0,0,1]) {
    // stack connectors along rack y axis
    translate(v = [-connectorRectWidth/2, -(stackConnectorDy+connectorRectDepth)/2, 2-overhangSlack])
    mirror(v = [0, 0, 1]) {
      translate(v = [0, stackConnectorDy, 0])
      stackConnectorBottom();

      stackConnectorBottom();
    }
    band();
  }

  module band() {
    intersection() {
      translate(v=[0,0,2])
      difference() {
        roundedCube(inf50, rackTotalDepth, height, 5, center = true);

        translate(v=[0,0,3])
        roundedCube(inf50, rackTotalDepth-6, height-6, 3, center = true);
      }

      halfspace(vpos=[1,0,-tan(feetProtrusionAngle)],p=[-8,0,2]);
      halfspace(vpos=[-1,0, tan(feetProtrusionAngle)],p=[6,0,2]);

      halfspace(vpos=[-1,0,0],p=[16,0,2]);
      halfspace(vpos=[1,0,0],p=[-5,0,2]);
    }
  }

  module roundedCube(x,y,z,r, center=false) {
    translate(v=[0,0,z/2])
    minkowski() {
      cube(size=[x,y-2*r,z-2*r], center=center);

      rotate(a=[0,90,0])
      cylinder(r=r, h=eps);
    }
  }
}

module rackTopFan120() {

  plateThickness = 3;
  plateInset = 8;
  plateX = rackTotalWidth - 2*plateInset;
  plateY = rackTotalDepth - 2*plateInset;
  fanOpeningR = 57;
  fanHoleSpacing = 105;
  fanHoleR = 2.3;
  mountBossR = 4;

  difference() {
    union() {
      translate(v=[plateInset, plateInset, 0])
      roundedPlate(plateX, plateY, plateThickness, 5);

      topPlug(connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge);
      topPlug(connectorXEdgeToYBarXEdge + stackConnectorDx, connectorYEdgeToYBarYEdge);
      topPlug(connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge + stackConnectorDy);
      topPlug(connectorXEdgeToYBarXEdge + stackConnectorDx, connectorYEdgeToYBarYEdge + stackConnectorDy);

      for (x = [rackTotalWidth/2 - fanHoleSpacing/2, rackTotalWidth/2 + fanHoleSpacing/2]) {
        for (y = [rackTotalDepth/2 - fanHoleSpacing/2, rackTotalDepth/2 + fanHoleSpacing/2]) {
          translate(v=[x, y, plateThickness])
          cylinder(r=mountBossR, h=3, $fn=32);
        }
      }
    }

    translate(v=[rackTotalWidth/2, rackTotalDepth/2, -1])
    cylinder(r=fanOpeningR, h=plateThickness+8, $fn=96);

    for (x = [rackTotalWidth/2 - fanHoleSpacing/2, rackTotalWidth/2 + fanHoleSpacing/2]) {
      for (y = [rackTotalDepth/2 - fanHoleSpacing/2, rackTotalDepth/2 + fanHoleSpacing/2]) {
        translate(v=[x, y, -1])
        cylinder(r=fanHoleR, h=plateThickness+8, $fn=32);
      }
    }
  }

  module topPlug(x, y) {
    translate(v=[x, y, 0])
    mirror(v=[0,0,1])
    stackConnectorPlug();
  }

  module roundedPlate(x, y, z, r) {
    minkowski() {
      translate(v=[r, r, 0])
      cube(size=[x-2*r, y-2*r, z-eps]);

      cylinder(r=r, h=eps, $fn=32);
    }
  }
}

module rackTopFan120Box() {

  plateThickness = 3;
  boxHeight = 31;
  wallThickness = 3;
  fanOpeningR = 57;
  fanHoleSpacing = 105;
  socketPad = 20;
  bottomInsertDepth = 1.5;

  difference() {
    union() {
      roundedBoxShell();

      topPlug(connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge);
      topPlug(connectorXEdgeToYBarXEdge + stackConnectorDx, connectorYEdgeToYBarYEdge);
      topPlug(connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge + stackConnectorDy);
      topPlug(connectorXEdgeToYBarXEdge + stackConnectorDx, connectorYEdgeToYBarYEdge + stackConnectorDy);
    }

    translate(v=[rackTotalWidth/2, rackTotalDepth/2, -1])
    cylinder(r=fanOpeningR, h=boxHeight+2, $fn=96);

    for (x = [rackTotalWidth/2 - fanHoleSpacing/2, rackTotalWidth/2 + fanHoleSpacing/2]) {
      for (y = [rackTotalDepth/2 - fanHoleSpacing/2, rackTotalDepth/2 + fanHoleSpacing/2]) {
        bottomM4FhcsThroughPlate(x, y);
      }
    }

    sideVents();

    bottomSocket(connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge);
    bottomSocket(connectorXEdgeToYBarXEdge + stackConnectorDx, connectorYEdgeToYBarYEdge);
    bottomSocket(connectorXEdgeToYBarXEdge, connectorYEdgeToYBarYEdge + stackConnectorDy);
    bottomSocket(connectorXEdgeToYBarXEdge + stackConnectorDx, connectorYEdgeToYBarYEdge + stackConnectorDy);
    bottomSocketSideScrewHoles();
  }

  module topPlug(x, y) {
    translate(v=[x, y, boxHeight])
    stackConnectorPlug();
  }

  module bottomSocket(x, y) {
    translate(v=[x, y, -0.1])
    stackConnectorBase(connectorRectSocketSlack, topSlack=0.4);
  }

  module bottomSocketSideScrewHoles() {
    for (y = [connectorYEdgeToYBarYEdge, connectorYEdgeToYBarYEdge + stackConnectorDy]) {
      translate(v=[
        connectorXEdgeToYBarXEdge - 4,
        y + connectorRectDepth/2,
        connectorBottomToScrew
      ])
      rotate(a=[0, -90, 0])
      counterSunkHead_N(rackFrameScrewType, screwExtension=5, headExtension=10);

      translate(v=[
        connectorXEdgeToYBarXEdge + stackConnectorDx + connectorRectWidth + 4,
        y + connectorRectDepth/2,
        connectorBottomToScrew
      ])
      rotate(a=[0, 90, 0])
      counterSunkHead_N(rackFrameScrewType, screwExtension=5, headExtension=10);
    }
  }

  module bottomM4FhcsThroughPlate(x, y) {
    translate(v=[x, y, -1])
    cylinder(r=m4RadiusSlacked, h=boxHeight+2, $fn=32);

    translate(v=[x, y, 0])
    cylinder(r1=m4CounterSunkHeadRadius, r2=m4RadiusSlacked, h=m4CounterSunkHeadLength, $fn=32);
  }

  module sideVents() {
    ventCenterZ = boxHeight/2;
    ventSlotWidth = 4;
    ventSlotHeight = 18;
    ventTargetPitch = 12;

    longUsableStart = socketPad + 2;
    longUsableEnd = rackTotalWidth - socketPad - 2;
    longUsable = longUsableEnd - longUsableStart;
    longVentCount = floor(longUsable / ventTargetPitch);
    longVentStep = longUsable / longVentCount;

    shortUsableStart = socketPad + 2;
    shortUsableEnd = rackTotalDepth - socketPad - 2;
    shortUsable = shortUsableEnd - shortUsableStart;
    shortVentCount = floor(shortUsable / ventTargetPitch);
    shortVentStep = shortUsable / shortVentCount;

    // Keep slots centered inside usable wall spans between the corner pads.
    for (i = [0:longVentCount-1]) {
      x = longUsableStart + longVentStep*(i+0.5);

      translate(v=[x, wallThickness/2, ventCenterZ])
      verticalVentThroughY(width=ventSlotWidth, height=ventSlotHeight, cutDepth=wallThickness+4);

      translate(v=[x, rackTotalDepth-wallThickness/2, ventCenterZ])
      verticalVentThroughY(width=ventSlotWidth, height=ventSlotHeight, cutDepth=wallThickness+4);
    }

    for (i = [0:shortVentCount-1]) {
      y = shortUsableStart + shortVentStep*(i+0.5);

      translate(v=[wallThickness/2, y, ventCenterZ])
      verticalVentThroughX(width=ventSlotWidth, height=ventSlotHeight, cutDepth=wallThickness+4);

      translate(v=[rackTotalWidth-wallThickness/2, y, ventCenterZ])
      verticalVentThroughX(width=ventSlotWidth, height=ventSlotHeight, cutDepth=wallThickness+4);
    }
  }

  module verticalVentThroughY(width, height, cutDepth) {
    r = width/2;
    hull() {
      translate(v=[0, 0, -height/2+r])
      rotate(a=[90,0,0])
      cylinder(r=r, h=cutDepth, center=true, $fn=24);

      translate(v=[0, 0, height/2-r])
      rotate(a=[90,0,0])
      cylinder(r=r, h=cutDepth, center=true, $fn=24);
    }
  }

  module verticalVentThroughX(width, height, cutDepth) {
    r = width/2;
    hull() {
      translate(v=[0, 0, -height/2+r])
      rotate(a=[0,90,0])
      cylinder(r=r, h=cutDepth, center=true, $fn=24);

      translate(v=[0, 0, height/2-r])
      rotate(a=[0,90,0])
      cylinder(r=r, h=cutDepth, center=true, $fn=24);
    }
  }

  module roundedBoxShell() {
    r = baseRoundness;

    difference() {
      fullyRoundedOuterPrism(rackTotalWidth, rackTotalDepth, boxHeight, r);

      // Remove the interior as straight wall cuts while preserving the
      // rounded corner structure and stack socket pad regions.
      translate(v=[socketPad, wallThickness, plateThickness])
      cube(size=[
        rackTotalWidth - 2*socketPad,
        rackTotalDepth - 2*wallThickness,
        boxHeight + 1
      ]);

      translate(v=[wallThickness, socketPad, plateThickness])
      cube(size=[
        rackTotalWidth - 2*wallThickness,
        rackTotalDepth - 2*socketPad,
        boxHeight + 1
      ]);
    }

    // Restore functional pad material inside the rounded corner shell without
    // letting square blocks protrude past the rounded exterior.
    intersection() {
      fullyRoundedOuterPrism(rackTotalWidth, rackTotalDepth, boxHeight, baseRoundness);
      union() {
        cornerPad(0, 0);
        cornerPad(rackTotalWidth-socketPad, 0);
        cornerPad(0, rackTotalDepth-socketPad);
        cornerPad(rackTotalWidth-socketPad, rackTotalDepth-socketPad);
      }
    }
  }

  module cornerPad(x, y) {
    translate(v=[x, y, plateThickness])
    squareRectPrism(socketPad, socketPad, boxHeight-plateThickness);
  }

  module fullyRoundedOuterPrism(x, y, z, r) {
    intersection() {
      minkowski() {
        sphere(r=r, $fn=32);

        translate(v=[r, r, r])
        cube(size=[x-2*r, y-2*r, z-2*r]);
      }

      cube(size=[x, y, z]);
    }
  }

  module squareRectPrism(x, y, z) {
    cube(size=[x, y, z]);
  }
}

rackTopHandle();

module rackTopHandle() {


  handleWidth = 20;
  handleHeight = 50;

  handleTopThickness = 10;
  handleBottomThickness = 10;
  handleSideThickness = 10;

  handleR = baseRoundness;

  handleRing();

  module handleRing() {

    w = handleWidth - 2*handleR;
    st = max(eps,handleSideThickness - 2*handleR);
    bt = max(eps,handleBottomThickness - 2*handleR);
    tt = max(eps,handleTopThickness - 2*handleR);

    y =100;

    minkowski() {

      sphere(r=handleR);

      ringFourHull() {
        cube(size = [w, st, bt]);

        translate(v = [0, y-handleSideThickness, 0])
          cube(size = [w, st, bt]);

        translate(v = [0, y-handleSideThickness, handleHeight-handleTopThickness])
          cube(size = [w, st, tt]);

        translate(v = [0, 0, handleHeight-handleTopThickness])
          cube(size = [w, st, tt]);
      }
    }

  }


  module ringFourHull() {
    union() {
      hull() {children(0); children(1);}
      hull() {children(1); children(2);}
      hull() {children(2); children(3);}
      hull() {children(3); children(0);}
    }
  }
}
