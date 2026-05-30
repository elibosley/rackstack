include <../../helper/common.scad>
include <../../rack/connector/stackYBarConnectors.scad>
use <./third_party/agentscad_drive35_sff8301.scad>

/*
  Mini PC NAS tower prototype:
    - one 134w x 126d mini PC mounts on top with its bottom mostly exposed
    - up to three vertical 3.5 in HDDs sit below it
    - drive SATA/power connectors point upward toward the mini PC
    - the center stays open as a cable chimney between drives and PC

  The mini PC is not supported by a solid plate. It lands on four screw bosses
  plus narrow perimeter bridge rails, so cabling can pass through the original
  bottom-cover opening without routing around a shelf.
*/

nasShellPrototypeAssembly();

outerW = 160;
outerD = 160;
wall = 3;
baseT = 5;

hddL = drive35_length();
hddD = drive35_width();
hddT = drive35_height_common();
driveBayClearX = 1.0;
hddSlotGap = 8;
hddCount = 4;
hddSlotW = hddT + driveBayClearX;
hddPitch = hddSlotW + hddSlotGap;
hddBankW = hddCount*hddSlotW + (hddCount - 1)*hddSlotGap;
hddBankX0 = (outerW - hddBankW) / 2;
hddFrontClear = 22;
hddY0 = hddFrontClear;
hddZ0 = baseT;
hddTopZ = hddZ0 + hddL;
hddScrewR = drive35_thread_clearance_radius(0.35);
hddScrewSlot = 0;
hddScrewOffsets = drive35_side_hole_offsets_from_connector_end();
hddConnectorKeepoutW = drive35_sata_connector_keepout_height();
hddConnectorKeepoutD = drive35_sata_connector_keepout_width();

pcBodyW = 134;
pcBodyD = 126;
pcPocketW = pcBodyW + 2;
pcPocketD = pcBodyD + 2;
pcH = 40;
pcX0 = (outerW - pcPocketW) / 2;
pcY0 = (outerD - pcPocketD) / 2;
pcCaseScrewPatternX = 129;
pcCaseScrewPatternY = 104;
pcCaseScrewR = m3RadiusSlacked;

cageTopRailT = 5;
plenumH = 34;
bridgeZ = hddTopZ + plenumH;
bridgeT = 6;
bridgeRailW = 12;
pcBossR = 7;
pcBossPadR = 10;
cageMountR = m3RadiusSlacked;
pcAccessWindow = true;
pcAccessWindowW = pcPocketW - 2*bridgeRailW;
pcAccessWindowD = pcPocketD - 2*bridgeRailW;
caseRoundR = 8;
panelRoundR = 7;
windowRoundR = 8;
postR = 4.8;
tableLegW = 16;
tableLegD = 16;
tableLegRoundR = 4;
tableLegH = bridgeZ - baseT;
panelT = wall;
frontRearPanelMountZs = [38, 96, 154];
sidePanelMountZs = [24, 82, 140];
panelNutR = (m3HexNutWidthAcrossCorners + xySlack) / 2;
panelNutT = m3HexNutThickness + xySlack;
panelNutSlotSlack = 0.4;
panelNutAccessClear = 0.6;
stackPlugX0 = 3;
stackPlugY0 = 3;
stackPlugPositions = [
  [stackPlugX0, stackPlugY0],
  [outerW - stackPlugX0 - connectorRectWidth, stackPlugY0],
  [stackPlugX0, outerD - stackPlugY0 - connectorRectDepth],
  [outerW - stackPlugX0 - connectorRectWidth, outerD - stackPlugY0 - connectorRectDepth]
];

carrierRailT = 5;
tpuSpacerOD = 8;
tpuSpacerID = drive35_thread_diameter() + 0.8;
tpuSpacerT = 1.6;
carrierDriveGapY = tpuSpacerT;
hddConnectorKeepoutY0 =
  carrierRailT + carrierDriveGapY + drive35_sata_connector_keepout_offset_from_side();
carrierSideMargin = 8;
driveRailW = 20;
driveRailT = 3.2;
driveRailChannelClear = 0.6;
driveRailReceiverDepth = 2.2;
driveRailLipW = 2.2;
driveRailPrintSpacing = 7;
driveRailScrewHeadR = 3.7;
driveRailScrewHeadDepth = 1.5;
carrierInsertW = hddBankW + 2*carrierSideMargin;
carrierInsertD = hddD + 2*driveRailT + 2*carrierDriveGapY;
carrierInsertH = hddL;
carrierBaseH = 8;
carrierEndPostW = 8;
carrierBaseRailW = 6;
carrierMountFootW = 20;
carrierMountFootD = 18;
carrierMountFootH = carrierBaseH;
carrierMountInsetX = carrierEndPostW + connectorRectWidth/2;
carrierMountInsetY = carrierRailT + connectorRectDepth/2 + 2;
carrierSideScrewBossH = connectorBottomToScrew + m3CounterSunkHeadRadius + 0.8;
carrierSideScrewBossD = 10;
carrierMountScrewR = m3RadiusSlacked;
carrierScrewStrapW = 18;
carrierRootRibW = 5;
carrierRootRibH = 8;
carrierSideTieH = 6;
carrierOuterCornerR = 4;
carrierPanelEdgeR = 2.5;
carrierFaceVentSlotW = hddSlotGap + driveBayClearX - 1.5;
carrierFaceVentSlotH = 22;
carrierFaceVentSlotPitchZ = 24;
carrierSideVentSlotW = 4;
carrierSideVentSlotH = 20;
carrierSideVentSlotPitchY = 14;
carrierSideVentSlotPitchZ = 24;
carrierVentChamfer = 0.8;
carrierVentChamferDepth = 0.7;
topClampOuterCornerR = 4;
topClampEdgeR = 2.5;
topClampMountInsetX = carrierSideMargin / 2;
topClampMountInsetY = carrierMountInsetY;
topClampPadPocketDepth = 1.2;
topClampNutRoofT = 2.0;
driveTopClampT = 4;
topClampLegLipT = 4;
topClampLegLipH = 14;
topClampLegLipR = 2;
topClampLegScrewZ = 10;
topClampLegScrewReach = tableLegD + topClampLegLipT + 2;
topBraceDriveWindowW = hddT + 1.4;
topBraceDriveWindowD = hddD + 1.4;
topBraceDriveWindowR = 3;
driveRetainerT = 4;
driveRetainerD = 16;
driveRetainerScrewEdge = 5;
driveRetainerScrewSpan = hddSlotW + hddSlotGap;
driveRetainerW = driveRetainerScrewSpan + 2*driveRetainerScrewEdge;
driveRetainerR = 2;
driveRetainerYFromRear = 22;
driveRetainerYStagger = 22;
driveRetainerDampingW = topBraceDriveWindowW - 4;
driveRetainerDampingD = driveRetainerD - 4;
topBraceRetainerNutCenterZ = (hexNutThickness("m3") + xySlack) / 2 - 0.05;

fan120Frame = 120;
fan120HoleSpacing = 105;
fanOpeningR = 64;
fanPreviewOpeningR = 52;
fanScrewR = m4RadiusSlacked;
fanThickness = 25;
fanCenterX = outerW/2;
fanCenterZ = hddZ0 + hddL/2;
rearUpperVentSlotW = outerW - 44;
rearUpperVentSlotH = 6;

utilityT = 3;
utilityLipH = 6;
drive25W = 70;
drive25D = 101;
drive25Clear = 2;
drive25ScrewR = m3RadiusSlacked;
buckMountR = m3RadiusSlacked;

module nasShellPrototypeAssembly() {
  color([0.21, 0.23, 0.24])
  nasShellHddCage();

  // Removable panels mount onto the outside faces of the table legs.
  color([0.12, 0.13, 0.13])
  translate(v=[0, -wall, 0])
  frontAccessPanelAssembly();

  color([0.12, 0.13, 0.13])
  translate(v=[0, wall, 0])
  nasShellRearPanel();

  color([0.12, 0.13, 0.13])
  translate(v=[-wall, 0, 0])
  leftAccessPanelAssembly();

  color([0.12, 0.13, 0.13])
  translate(v=[wall, 0, 0])
  rightAccessPanelAssembly();

  translate(v=[carrierInsertX0(), carrierInsertY0(), baseT])
  color([0.34, 0.35, 0.34])
  nasShellDriveSled();

  for (i = [0:hddCount - 1]) {
    color([0.08, 0.36, 0.40])
    nasShellDriveRailInstalled(i);
  }

  translate(v=[carrierInsertX0(), carrierInsertY0(), hddTopZ])
  color([0.26, 0.30, 0.30])
  nasShellDriveTopClamp();

  translate(v=[carrierInsertX0(), carrierInsertY0(), hddTopZ])
  color([0.18, 0.22, 0.22])
  nasShellDriveRetainers();

  for (i = [0:hddCount - 1]) {
    %translate(v=[driveSlotX(i) - hddT/2, hddY0, hddZ0])
    cube(size=[hddT, hddD, hddL]);
  }

  translate(v=[0, 0, bridgeZ])
  color([0.34, 0.36, 0.36])
  nasShellPcBottomAdapter();

  translate(v=[outerW - wall - utilityT, 15, hddZ0 + 22])
  rotate(a=[0, 0, 0])
  color([0.38, 0.39, 0.37])
  nasShellHardwareShelf();

  translate(v=[fanCenterX - fan120Frame/2, outerD - fanThickness, fanCenterZ - fan120Frame/2])
  color([0.08, 0.08, 0.08])
  fan120Preview();

  %translate(v=[pcX0, pcY0, bridgeZ + bridgeT])
  cube(size=[pcPocketW, pcPocketD, pcH]);
}

module nasShellDriveRailInstalled(i) {
  x0 = driveSlotX(i) - driveRailW/2;

  translate(v=[x0, hddY0 - driveRailT, hddZ0])
  color([0.08, 0.36, 0.40])
  driveRail(headOnPositiveY=false);

  translate(v=[x0, hddY0 + hddD, hddZ0])
  color([0.08, 0.36, 0.40])
  driveRailRear();
}

module nasShellDriveRailPair() {
  driveRail(headOnPositiveY=false);

  translate(v=[0, driveRailT + driveRailPrintSpacing, 0])
  driveRailRear();
}

module nasShellDriveShoe() {
  nasShellDriveRailPair();
}

module driveRail(headOnPositiveY=false) {
  difference() {
    union() {
      roundedPanelXz(width=driveRailW, thickness=driveRailT, height=hddL, r=1.4);

      translate(v=[0, driveRailT - 0.8, 0])
      roundedPanelXz(width=2.2, thickness=0.8, height=hddL, r=0.8);

      translate(v=[driveRailW - 2.2, driveRailT - 0.8, 0])
      roundedPanelXz(width=2.2, thickness=0.8, height=hddL, r=0.8);
    }

    driveRailScrewSlots(headOnPositiveY=headOnPositiveY);
    driveRailFlexReliefs();
  }
}

module driveRailRear() {
  translate(v=[0, driveRailT, 0])
  mirror(v=[0, 1, 0])
  driveRail(headOnPositiveY=false);
}

module driveRailScrewSlots(headOnPositiveY=false) {
  headCenterY = headOnPositiveY
    ? driveRailT - driveRailScrewHeadDepth/2
    : driveRailScrewHeadDepth/2;

  for (z = hddSideScrewZs()) {
    translate(v=[driveRailW/2, driveRailT/2, z])
    rotate(a=[-90, 0, 0])
    cylinder(r=hddScrewR, h=driveRailT + 2, center=true, $fn=32);

    translate(v=[driveRailW/2, headCenterY, z])
    rotate(a=[-90, 0, 0])
    cylinder(r=driveRailScrewHeadR, h=driveRailScrewHeadDepth + 0.2, center=true, $fn=40);
  }
}

module driveRailFlexReliefs() {
  for (z = [hddL*0.32, hddL*0.68]) {
    translate(v=[driveRailW/2, driveRailT/2, z])
    verticalSlotThroughY(width=3.5, height=18, depth=driveRailT + 2);
  }
}

module nasShellDriveSlotTest() {
  testH = 34;

  difference() {
    union() {
      driveCarrierRailChannels(height=testH);
      driveCarrierBaseRails();
      driveCarrierSideScrewBosses();
    }

    driveCarrierVentCutouts();
    driveCarrierNutPockets();
    driveCarrierOuterCornerCutouts(height=testH);
  }
}

module nasShellDriveFitCheck() {
  color([0.34, 0.35, 0.34])
  nasShellDriveSled();

  for (i = [0:hddCount - 1]) {
    translate(v=[-carrierInsertX0(), -carrierInsertY0(), -baseT])
    color([0.08, 0.36, 0.40])
    nasShellDriveRailInstalled(i);

    %translate(v=[
      driveSlotX(i) - hddT/2 - carrierInsertX0(),
      hddY0 - carrierInsertY0(),
      hddZ0 - baseT
    ])
    cube(size=[hddT, hddD, hddL]);
  }
}

module nasShellDriveTopClamp() {
  difference() {
    union() {
      topClampFrame();
      topClampLegLips();
    }

    topClampMountCutouts();
    topClampLegScrewCutouts();
    topBraceDriveAccessWindows();
    topBraceRetainerNutPockets();
  }
}

module topClampMountCutouts() {
  for (p = driveCarrierTopClampMountCenters()) {
    translate(v=[p[0], p[1], -1])
    cylinder(r=m3RadiusSlacked, h=driveTopClampT + 2, $fn=24);

    translate(v=[p[0], p[1], driveTopClampT])
    counterSunkHead_N("m3", screwExtension=driveTopClampT + 6, headExtension=2);
  }
}

module topClampLegLips() {
  translate(v=[topClampLegLipX0(), topClampFrontLipY0(), 0])
  roundedPanelXz(
    width=topClampLegLipW(),
    thickness=topClampLegLipT,
    height=topClampLegLipH,
    r=topClampLegLipR
  );

  translate(v=[topClampLegLipX0(), topClampRearLipY0(), 0])
  roundedPanelXz(
    width=topClampLegLipW(),
    thickness=topClampLegLipT,
    height=topClampLegLipH,
    r=topClampLegLipR
  );
}

module topClampLegScrewCutouts() {
  for (p = topClampFrontLegScrewLocalCenters()) {
    m3FhcsThroughY(
      x=p[0],
      headY=topClampFrontLipY0() + topClampLegLipT,
      z=topClampLegScrewZ,
      direction=-1,
      length=topClampLegScrewReach
    );
  }

  for (p = topClampRearLegScrewLocalCenters()) {
    m3FhcsThroughY(
      x=p[0],
      headY=topClampRearLipY0(),
      z=topClampLegScrewZ,
      direction=1,
      length=topClampLegScrewReach
    );
  }
}

module m3FhcsThroughY(x, headY, z, direction, length) {
  translate(v=[x, headY + direction*length/2, z])
  rotate(a=[90, 0, 0])
  cylinder(r=m3RadiusSlacked, h=length + 2, center=true, $fn=32);

  translate(v=[x, headY, z])
  rotate(a=direction < 0 ? [-90, 0, 0] : [90, 0, 0])
  counterSunkHead_N("m3", screwExtension=length + 2, headExtension=2);
}

module topClampFrame() {
  translate(v=[topClampPlateX0(), topClampPlateY0(), 0])
  roundedPlateXY(
    width=topClampPlateW(),
    depth=topClampPlateD(),
    height=driveTopClampT,
    r=topClampOuterCornerR
  );
}

module topBraceDriveAccessWindows() {
  for (i = [0:hddCount - 1]) {
    translate(v=[
      carrierSlotX(i),
      topBraceDriveWindowY0() + topBraceDriveWindowD/2,
      -1
    ])
    roundedWindowThroughZ(
      width=topBraceDriveWindowW,
      depth=topBraceDriveWindowD,
      height=driveTopClampT + 2,
      r=topBraceDriveWindowR
    );
  }
}

module topBraceRetainerNutPockets() {
  for (i = [0:hddCount - 1]) {
    for (p = driveRetainerScrewCenters(i)) {
      translate(v=[p[0], p[1], topBraceRetainerNutCenterZ])
      hexNutPocket_N("m3", openSide=false, backSpace=driveTopClampT + 2);
    }
  }
}

module nasShellDriveRetainers() {
  for (i = [0:hddCount - 1]) {
    translate(v=[driveRetainerX0(i), driveRetainerY0(i), 0])
    nasShellDriveRetainer();
  }
}

module nasShellDriveRetainer() {
  difference() {
    roundedPlateXY(
      width=driveRetainerW,
      depth=driveRetainerD,
      height=driveRetainerT,
      r=driveRetainerR
    );

    driveRetainerMountCutouts();
    driveRetainerDampingPocket();
  }
}

module driveRetainerMountCutouts() {
  for (p = driveRetainerLocalScrewCenters()) {
    translate(v=[p[0], p[1], -1])
    cylinder(r=m3RadiusSlacked, h=driveRetainerT + 2, $fn=24);

    translate(v=[p[0], p[1], driveRetainerT])
    counterSunkHead_N("m3", screwExtension=driveRetainerT + 6, headExtension=2);
  }
}

module driveRetainerDampingPocket() {
  translate(v=[
    driveRetainerW/2 - driveRetainerDampingW/2,
    driveRetainerD/2 - driveRetainerDampingD/2,
    -0.1
  ])
  roundedPlateXY(
    width=driveRetainerDampingW,
    depth=driveRetainerDampingD,
    height=topClampPadPocketDepth + 0.1,
    r=1.2
  );
}

module nasShellPcBottomAdapter() {
  difference() {
    union() {
      pcMountTopPlate();
      adapterStackConnectorPlugs();
    }

    pcBottomAccessWindow();
    pcCaseFhcsHoles();
  }
}

module adapterStackConnectorPlugs() {
  for (p = stackPlugPositions) {
    translate(v=[p[0], p[1], 0])
    mirror(v=[0, 0, 1])
    stackConnectorPlug();
  }
}

module nasShellHddCage() {
  nasShellTableBase();
  tableLegs();
}

module nasShellTableBase() {
  difference() {
    union() {
      roundedPlateXY(width=outerW, depth=outerD, height=baseT, r=caseRoundR);

      baseLegConnectorPlugs();
      baseCarrierConnectorPlugs();
    }
  }
}

module baseLegConnectorPlugs() {
  for (p = stackPlugPositions) {
    translate(v=[p[0], p[1], baseT])
    stackConnectorPlug();
  }
}

module baseCarrierConnectorPlugs() {
  for (p = carrierMountCenters()) {
    translate(v=[p[0] - connectorRectWidth/2, p[1] - connectorRectDepth/2, baseT])
    clippedStackConnectorPlug(height=carrierMountFootH);
  }
}

module clippedStackConnectorPlug(height) {
  intersection() {
    stackConnectorPlug();

    translate(v=[-1, -1, -1])
    cube(size=[connectorRectWidth + 2, connectorRectDepth + 2, height + 1]);
  }
}

module nasShellTableLegFrontLeft() {
  nasShellTableLeg(x0=0, y0=0);
}

module nasShellTableLegFrontRight() {
  nasShellTableLeg(x0=outerW - tableLegW, y0=0);
}

module nasShellTableLegRearLeft() {
  nasShellTableLeg(x0=0, y0=outerD - tableLegD);
}

module nasShellTableLegRearRight() {
  nasShellTableLeg(x0=outerW - tableLegW, y0=outerD - tableLegD);
}

module nasShellTableLeg(x0, y0) {
  fromLeft = x0 < outerW/2;
  fromFront = y0 < outerD/2;

  difference() {
    roundedPlateXY(width=tableLegW, depth=tableLegD, height=tableLegH, r=tableLegRoundR);

    tableLegBottomStackSocket();
    tableLegTopStackSocket();
    tableLegStackSocketSideScrewHole(z=connectorBottomToScrew, fromLeft=fromLeft);
    tableLegStackSocketSideScrewHole(z=tableLegH - connectorBottomToScrew, fromLeft=fromLeft);

    for (z = frontRearPanelMountZs) {
      m3FrontBackPanelNutPocket(
        center=[tableLegW/2, tableLegD/2, z - baseT],
        openTowardCenterX=fromLeft
      );
    }

    m3FrontBackPanelNutPocket(
      center=[tableLegW/2, tableLegD/2, topClampLegScrewGlobalZ() - baseT],
      openTowardCenterX=fromLeft
    );

    for (z = sidePanelMountZs) {
      m3SidePanelNutPocket(
        center=[tableLegW/2, tableLegD/2, z - baseT],
        openTowardCenterY=fromFront
      );
    }
  }
}

module tableLegBottomStackSocket() {
  translate(v=[stackPlugX0, stackPlugY0, -0.1])
  stackConnectorBase(connectorRectSocketSlack, topSlack=0.4);
}

module tableLegTopStackSocket() {
  translate(v=[stackPlugX0, stackPlugY0, tableLegH + 0.1])
  mirror(v=[0, 0, 1])
  stackConnectorBase(connectorRectSocketSlack, topSlack=0.4);
}

module tableLegStackSocketSideScrewHole(z, fromLeft) {
  x = fromLeft ? 0 : tableLegW;
  rot = fromLeft ? [0, -90, 0] : [0, 90, 0];

  translate(v=[x, stackPlugY0 + connectorRectDepth/2, z])
  rotate(a=rot)
  counterSunkHead_N("m3", screwExtension=tableLegW + 2, headExtension=8);
}

module nasShellFrontPanel() {
  nasShellCommonAccessPanel(frontBackMountPattern=true);
}

module nasShellRearPanel() {
  difference() {
    rearPanel();

    rearPanelVentCutouts();
    rearFanCutouts();
    rearPanelMountHoles();
  }
}

module nasShellLeftPanel() {
  nasShellCommonAccessPanel(frontBackMountPattern=false);
}

module nasShellRightPanel() {
  nasShellCommonAccessPanel(frontBackMountPattern=false);
}

module nasShellCommonAccessPanel(frontBackMountPattern=true) {
  difference() {
    commonAccessPanelBody();
    commonAccessPanelFullHeightSlots();

    if (frontBackMountPattern) {
      commonPanelFrontBackMountHoles();
    } else {
      commonPanelSideMountHoles();
    }
  }
}

module frontAccessPanelAssembly() {
  difference() {
    frontPanel();
    commonAccessPanelFullHeightSlots();
    commonPanelFrontBackMountHoles();
  }
}

module leftAccessPanelAssembly() {
  difference() {
    leftPanel();
    leftPanelFullHeightSlots();
    leftPanelMountHoles();
  }
}

module rightAccessPanelAssembly() {
  difference() {
    rightPanel();
    rightPanelFullHeightSlots();
    rightPanelMountHoles();
  }
}

module nasShellPcBottomAdapterOld() {
  difference() {
    pcMountTopPlate();

    pcBottomAccessWindow();
    pcCaseFhcsHoles();
    adapterCageMountHoles();
  }
}

module nasShellHddCageOld() {
  difference() {
    union() {
      roundedPlateXY(width=outerW, depth=outerD, height=baseT, r=caseRoundR);

      tableLegs();
      lowerCaseFeet();
    }

    carrierBottomMountHoles();
    tableLegPanelNutPockets();
    bridgeMountHoles();
  }
}

module _obsolete_after_redesign_marker() {
  if (false) {
    translate(v=[0, 0, 0])
    color([0.08, 0.36, 0.40])
    cube(size=[1, 1, 1]);
  }
}

module nasShellHardwareShelf() {
  shelfW = 118;
  shelfH = 104;

  difference() {
    union() {
      roundedPlateXY(width=utilityT, depth=shelfW, height=shelfH, r=1.2);

      translate(v=[0, 0, 0])
      cube(size=[utilityT + utilityLipH, wall, shelfH]);

      translate(v=[0, shelfW - wall, 0])
      cube(size=[utilityT + utilityLipH, wall, shelfH]);

      translate(v=[0, 0, 0])
      cube(size=[utilityT + utilityLipH, shelfW, wall]);
    }

    utilityShelfVentSlots(shelfW=shelfW, shelfH=shelfH);
    drive25SideMountHoles();
    buckSideMountHoles();
  }
}

module nasShellDriveSled() {
  difference() {
    union() {
      driveCarrierPanels();
      driveCarrierLaneGuides();
      driveCarrierBaseRails();
      driveCarrierMountFeet();
      driveCarrierSideScrewBosses();
    }

    driveCarrierVentCutouts();
    driveCarrierNutPockets();
    driveCarrierTopClampNutPockets();
    driveCarrierOuterCornerCutouts(height=hddL);
  }
}

module driveCarrierPanels() {
  driveCarrierRailChannels(height=hddL);
}

module driveCarrierLaneGuides() {
  // Rail channels replace the old full-height bay dividers. Keeping the open
  // middle improves front-to-back airflow through four drives.
}

module driveCarrierRailChannels(height) {
  for (y = [0, carrierInsertD - carrierRailT]) {
    driveCarrierSlottedRailPlate(y=y, height=height);
  }

  driveCarrierSideTies(height=height);
}

module driveCarrierSlottedRailPlate(y, height) {
  channelW = driveRailW + driveRailChannelClear;
  channelDepth = driveRailT + driveRailChannelClear;
  isFront = y < carrierInsertD/2;
  channelY = isFront
    ? y + carrierRailT - driveRailReceiverDepth
    : y - channelDepth + driveRailReceiverDepth;
  channelD = channelDepth;

  difference() {
    translate(v=[0, y, 0])
    roundedPanelXz(width=carrierInsertW, thickness=carrierRailT, height=height, r=carrierPanelEdgeR);

    for (i = [0:hddCount - 1]) {
      translate(v=[carrierSlotX(i) - channelW/2, channelY, carrierBaseH])
      cube(size=[channelW, channelD, height - carrierBaseH + 2]);
    }
  }
}

module driveCarrierSideTies(height) {
  for (x = [0, carrierInsertW - carrierEndPostW]) {
    translate(v=[x, 0, 0])
    roundedPanelYz(thickness=carrierEndPostW, depth=carrierInsertD, height=height, r=carrierPanelEdgeR);
  }
}

module driveCarrierBaseRails() {
  railW = carrierBaseRailW;

  translate(v=[0, 0, 0])
  roundedPlateXY(width=carrierInsertW, depth=railW, height=carrierBaseH, r=2);

  translate(v=[0, carrierInsertD - railW, 0])
  roundedPlateXY(width=carrierInsertW, depth=railW, height=carrierBaseH, r=2);

  translate(v=[0, 0, 0])
  roundedPlateXY(width=railW, depth=carrierInsertD, height=carrierBaseH, r=2);

  translate(v=[carrierInsertW - railW, 0, 0])
  roundedPlateXY(width=railW, depth=carrierInsertD, height=carrierBaseH, r=2);

  for (i = [0:hddCount - 1]) {
    translate(v=[carrierSlotX(i) - carrierRootRibW/2, 0, 0])
    roundedPlateXY(width=carrierRootRibW, depth=carrierInsertD, height=carrierRootRibH, r=1.5);
  }
}

module driveCarrierMountFeet() {
  for (p = carrierMountLocalCenters()) {
    translate(v=[p[0] - carrierMountFootW/2, p[1] - carrierMountFootD/2, 0])
    roundedPlateXY(width=carrierMountFootW, depth=carrierMountFootD, height=carrierMountFootH, r=3);
  }
}

module driveCarrierSideScrewBosses() {
  for (p = carrierMountLocalCenters()) {
    fromLeft = p[0] < carrierInsertW/2;
    x0 = fromLeft ? 0 : carrierInsertW - carrierEndPostW;

    translate(v=[x0, p[1] - carrierSideScrewBossD/2, 0])
    roundedPlateXY(
      width=carrierEndPostW,
      depth=carrierSideScrewBossD,
      height=carrierSideScrewBossH,
      r=2
    );
  }
}

module driveCarrierVentCutouts() {
  driveCarrierFaceVentSlots();
  driveCarrierSideTieVentSlots();
}

module driveCarrierFaceVentSlots() {
  for (y = [carrierRailT/2, carrierInsertD - carrierRailT/2]) {
    for (x = carrierAirflowSlotXs()) {
      for (z = [carrierBaseH + 14:carrierFaceVentSlotPitchZ:hddL - 14]) {
        translate(v=[x, y, z])
        chamferedVerticalSlotThroughY(
          width=carrierFaceVentSlotW,
          height=carrierFaceVentSlotH,
          depth=carrierRailT,
          chamfer=carrierVentChamfer,
          chamferDepth=carrierVentChamferDepth
        );
      }
    }
  }
}

module driveCarrierSideTieVentSlots() {
  for (x = [carrierEndPostW/2, carrierInsertW - carrierEndPostW/2]) {
    for (y = [carrierRailT + 14:carrierSideVentSlotPitchY:carrierInsertD - carrierRailT - 14]) {
      for (z = [carrierBaseH + 16:carrierSideVentSlotPitchZ:hddL - 16]) {
        translate(v=[x, y, z])
        chamferedVerticalSlotThroughX(
          width=carrierSideVentSlotW,
          height=carrierSideVentSlotH,
          depth=carrierEndPostW,
          chamfer=carrierVentChamfer,
          chamferDepth=carrierVentChamferDepth
        );
      }
    }
  }
}

module driveCarrierOuterCornerCutouts(height) {
  roundedRectOutsideCornerCutouts(
    width=carrierInsertW,
    depth=carrierInsertD,
    height=height + 2,
    r=carrierOuterCornerR
  );
}

module driveCarrierHddScrewSlots() {
  // Drive screw clearance moved to nasShellDriveShoe().
}

module driveCarrierNutPockets() {
  for (p = carrierMountLocalCenters()) {
    translate(v=[p[0] - connectorRectWidth/2, p[1] - connectorRectDepth/2, -0.1])
    stackConnectorBase(connectorRectSocketSlack, topSlack=0.4);

    driveCarrierBaseSocketSideScrewHole(p=p);
  }
}

module driveCarrierBaseSocketSideScrewHole(p) {
  fromLeft = p[0] < carrierInsertW/2;
  x = fromLeft ? 0 : carrierInsertW;
  rot = fromLeft ? [0, -90, 0] : [0, 90, 0];

  translate(v=[x, p[1], connectorBottomToScrew])
  rotate(a=rot)
  counterSunkHead_N("m3", screwExtension=carrierMountFootW + 4, headExtension=8);
}

module driveCarrierTopClampNutPockets() {
  for (p = driveCarrierTopClampMountCenters()) {
    translate(v=[p[0], p[1], topClampNutPocketCenterZ()])
    hexNutPocket_N("m3", openSide=false, backSpace=8, bridgeBack=true);
  }
}

module nasShellHddTpuSpacerSheet(count=12) {
  pitch = tpuSpacerOD + 4;
  cols = 4;

  for (i = [0:count - 1]) {
    translate(v=[(i % cols) * pitch, floor(i / cols) * pitch, 0])
    nasShellHddTpuSpacer();
  }
}

module nasShellHddTpuSpacer() {
  difference() {
    cylinder(r=tpuSpacerOD/2, h=tpuSpacerT, $fn=40);

    translate(v=[0, 0, -1])
    cylinder(r=tpuSpacerID/2, h=tpuSpacerT + 2, $fn=32);
  }
}

module nasShellPcScrewTemplate() {
  templateT = 1.2;

  difference() {
    roundedPlateXY(width=pcPocketW, depth=pcPocketD, height=templateT, r=5);

    for (p = pcCaseScrewCenters()) {
      translate(v=[p[0] - pcX0, p[1] - pcY0, -1])
      cylinder(r=pcCaseScrewR, h=templateT + 2, $fn=24);
    }

    translate(v=[pcPocketW/2, pcPocketD/2, -1])
    roundedWindowThroughZ(width=pcPocketW - 28, depth=pcPocketD - 28, height=templateT + 2, r=windowRoundR);
  }
}

module commonAccessPanelBody() {
  roundedPanelXz(width=outerW, thickness=wall, height=bridgeZ, r=panelRoundR);
}

module frontPanel() {
  commonAccessPanelBody();
}

module rearPanel() {
  translate(v=[0, outerD - wall, 0])
  roundedPanelXz(width=outerW, thickness=wall, height=bridgeZ, r=panelRoundR);
}

module leftPanel() {
  roundedPanelYz(thickness=wall, depth=outerD, height=bridgeZ, r=panelRoundR);
}

module rightPanel() {
  translate(v=[outerW - wall, 0, 0])
  roundedPanelYz(thickness=wall, depth=outerD, height=bridgeZ, r=panelRoundR);
}

module tableLegs() {
  translate(v=[0, 0, baseT])
  nasShellTableLegFrontLeft();

  translate(v=[outerW - tableLegW, 0, baseT])
  nasShellTableLegFrontRight();

  translate(v=[0, outerD - tableLegD, baseT])
  nasShellTableLegRearLeft();

  translate(v=[outerW - tableLegW, outerD - tableLegD, baseT])
  nasShellTableLegRearRight();
}

module lowerCaseFeet() {
  footW = 34;
  footD = 8;

  for (x = [18, outerW - 18 - footW]) {
    translate(v=[x, -footD/2, 0])
    roundedPlateXY(width=footW, depth=footD, height=baseT, r=3);

    translate(v=[x, outerD - footD/2, 0])
    roundedPlateXY(width=footW, depth=footD, height=baseT, r=3);
  }
}

module pcMountTopPlate() {
  roundedPlateXY(width=outerW, depth=outerD, height=bridgeT, r=caseRoundR);
}

module pcBottomAccessWindow() {
  if (pcAccessWindow) {
    translate(v=[outerW/2, outerD/2, -1])
    roundedWindowThroughZ(width=pcAccessWindowW, depth=pcAccessWindowD, height=bridgeT + 2, r=windowRoundR);
  }
}

module pcCaseFhcsHoles() {
  for (p = pcCaseScrewCenters()) {
    // Screws install from the underside of the adapter into the mini PC shell.
    translate(v=[p[0], p[1], 0])
    rotate(a=[180, 0, 0])
    counterSunkHead_N("m3", screwExtension=bridgeT + 4, headExtension=2);
  }
}

module adapterCageMountHoles() {
  for (p = cageMountCenters()) {
    translate(v=[p[0], p[1], bridgeT])
    counterSunkHead_N("m3", screwExtension=bridgeT + 4, headExtension=2);
  }
}

module frontPanelVentCutouts() {
  commonAccessPanelFullHeightSlots();
}

module commonAccessPanelFullHeightSlots() {
  slotH = bridgeZ - 28;

  for (x = accessPanelSlotXs()) {
    translate(v=[x, wall/2, bridgeZ/2])
    verticalSlotThroughY(width=5, height=slotH, depth=wall + 2);
  }
}

module rearPanelVentCutouts() {
  for (z = [fanCenterZ + fanOpeningR + 17, fanCenterZ + fanOpeningR + 31]) {
    translate(v=[fanCenterX, outerD - wall/2, z])
    roundedWindowThroughY(
      width=rearUpperVentSlotW,
      depth=wall + 2,
      height=rearUpperVentSlotH,
      r=rearUpperVentSlotH/2
    );
  }
}

module leftPanelVentCutouts() {
  leftPanelFullHeightSlots();
}

module rightPanelVentCutouts() {
  rightPanelFullHeightSlots();
}

module leftPanelFullHeightSlots() {
  slotH = bridgeZ - 28;

  for (y = accessPanelSlotXs()) {
    translate(v=[wall/2, y, bridgeZ/2])
    verticalSlotThroughX(width=5, height=slotH, depth=wall + 2);
  }
}

module rightPanelFullHeightSlots() {
  slotH = bridgeZ - 28;

  for (y = accessPanelSlotXs()) {
    translate(v=[outerW - wall/2, y, bridgeZ/2])
    verticalSlotThroughX(width=5, height=slotH, depth=wall + 2);
  }
}

module commonPanelFrontBackMountHoles() {
  for (p = frontRearPanelMountCenters()) {
    translate(v=[p[0], 0, p[1]])
    rotate(a=[90, 0, 0])
    counterSunkHead_N("m3", screwExtension=panelT + tableLegD + 2, headExtension=2);
  }
}

module commonPanelSideMountHoles() {
  for (p = leftRightPanelMountCenters()) {
    translate(v=[p[0], 0, p[1]])
    rotate(a=[90, 0, 0])
    counterSunkHead_N("m3", screwExtension=panelT + tableLegD + 2, headExtension=2);
  }
}

module frontPanelMountHoles() {
  for (p = frontRearPanelMountCenters()) {
    translate(v=[p[0], 0, p[1]])
    rotate(a=[90, 0, 0])
    counterSunkHead_N("m3", screwExtension=panelT + tableLegD + 2, headExtension=2);
  }
}

module rearPanelMountHoles() {
  for (p = frontRearPanelMountCenters()) {
    translate(v=[p[0], outerD, p[1]])
    rotate(a=[-90, 0, 0])
    counterSunkHead_N("m3", screwExtension=panelT + tableLegD + 2, headExtension=2);
  }
}

module leftPanelMountHoles() {
  for (p = leftRightPanelMountCenters()) {
    translate(v=[0, p[0], p[1]])
    rotate(a=[0, -90, 0])
    counterSunkHead_N("m3", screwExtension=panelT + tableLegW + 2, headExtension=2);
  }
}

module rightPanelMountHoles() {
  for (p = leftRightPanelMountCenters()) {
    translate(v=[outerW, p[0], p[1]])
    rotate(a=[0, 90, 0])
    counterSunkHead_N("m3", screwExtension=panelT + tableLegW + 2, headExtension=2);
  }
}

module tableLegPanelNutPockets() {
  for (p = frontRearPanelMountCenters()) {
    m3FrontBackPanelNutPocket(center=[p[0], tableLegD/2, p[1]], openTowardCenterX=p[0] < outerW/2);
    m3FrontBackPanelNutPocket(center=[p[0], outerD - tableLegD/2, p[1]], openTowardCenterX=p[0] < outerW/2);
  }

  for (p = leftRightPanelMountCenters()) {
    m3SidePanelNutPocket(center=[tableLegW/2, p[0], p[1]], openTowardCenterY=p[0] < outerD/2);
    m3SidePanelNutPocket(center=[outerW - tableLegW/2, p[0], p[1]], openTowardCenterY=p[0] < outerD/2);
  }
}

module tableTopStackSockets() {
  for (p = stackPlugPositions) {
    translate(v=[p[0], p[1], bridgeZ + 0.1])
    mirror(v=[0, 0, 1])
    stackConnectorBase(connectorRectSocketSlack, topSlack=0.4);
  }
}

module tableTopSocketSideScrewHoles() {
  z = bridgeZ - connectorBottomToScrew;

  for (p = stackPlugPositions) {
    fromLeft = p[0] < outerW/2;
    x = fromLeft ? 0 : outerW;
    rot = fromLeft ? [0, -90, 0] : [0, 90, 0];

    translate(v=[x, p[1] + connectorRectDepth/2, z])
    rotate(a=rot)
    counterSunkHead_N("m3", screwExtension=tableLegW + 2, headExtension=8);
  }
}

module m3FrontBackPanelNutPocket(center, openTowardCenterX) {
  slotX0 = openTowardCenterX ? center[0] : center[0] - tableLegW/2 - 1;
  slotLen = tableLegW/2 + 1;

  translate(v=center)
  rotate(a=[90, 0, 0])
  cylinder(r=panelNutR, h=panelNutT, center=true, $fn=6);

  translate(v=[slotX0, center[1] - panelNutT/2 - panelNutAccessClear/2, center[2] - panelNutR - panelNutAccessClear/2])
  cube(size=[slotLen, panelNutT + panelNutAccessClear, 2*panelNutR + panelNutAccessClear]);

  translate(v=center)
  rotate(a=[90, 0, 0])
  cylinder(r=m3RadiusSlacked, h=tableLegD + panelT + 2, center=true, $fn=24);
}

module m3SidePanelNutPocket(center, openTowardCenterY) {
  slotY0 = openTowardCenterY ? center[1] : center[1] - tableLegD/2 - 1;
  slotLen = tableLegD/2 + 1;

  translate(v=center)
  rotate(a=[0, 90, 0])
  cylinder(r=panelNutR, h=panelNutT, center=true, $fn=6);

  translate(v=[center[0] - panelNutT/2 - panelNutAccessClear/2, slotY0, center[2] - panelNutR - panelNutAccessClear/2])
  cube(size=[panelNutT + panelNutAccessClear, slotLen, 2*panelNutR + panelNutAccessClear]);

  translate(v=center)
  rotate(a=[0, 90, 0])
  cylinder(r=m3RadiusSlacked, h=tableLegW + panelT + 2, center=true, $fn=24);
}

module carrierBottomMountHoles() {
  for (p = carrierMountCenters()) {
    translate(v=[p[0], p[1], 0])
    rotate(a=[180, 0, 0])
    counterSunkHead_N("m3", screwExtension=baseT + carrierMountFootH + 4, headExtension=2);
  }
}

module rearFanCutouts() {
  translate(v=[fanCenterX, outerD - wall/2, fanCenterZ])
  rotate(a=[90, 0, 0])
  cylinder(r=fanOpeningR, h=wall + 4, center=true, $fn=96);

  for (p = fanScrewCenters()) {
    translate(v=[p[0], outerD, p[1]])
    rotate(a=[-90, 0, 0])
    counterSunkHead_N("m4", screwExtension=wall + 4, headExtension=2);
  }
}

module frontCaseDetails() {
  stripZ = bridgeZ - 20;

  translate(v=[outerW/2, wall/2, stripZ])
  roundedWindowThroughY(width=86, depth=wall + 2, height=13, r=3);

  translate(v=[outerW - 28, wall/2, stripZ])
  rotate(a=[90, 0, 0])
  cylinder(r=4, h=wall + 2, center=true, $fn=32);

  for (x = [outerW - 44, outerW - 38]) {
    translate(v=[x, wall/2, stripZ])
    rotate(a=[90, 0, 0])
    cylinder(r=1.5, h=wall + 2, center=true, $fn=20);
  }

}

module fan120Preview() {
  difference() {
    roundedPanelXz(width=fan120Frame, thickness=fanThickness, height=fan120Frame, r=6);

    translate(v=[fan120Frame/2, fanThickness/2, fan120Frame/2])
    rotate(a=[90, 0, 0])
    cylinder(r=fanPreviewOpeningR, h=fanThickness + 2, center=true, $fn=96);

    for (p = [
      [fan120Frame/2 - fan120HoleSpacing/2, fan120Frame/2 - fan120HoleSpacing/2],
      [fan120Frame/2 + fan120HoleSpacing/2, fan120Frame/2 - fan120HoleSpacing/2],
      [fan120Frame/2 - fan120HoleSpacing/2, fan120Frame/2 + fan120HoleSpacing/2],
      [fan120Frame/2 + fan120HoleSpacing/2, fan120Frame/2 + fan120HoleSpacing/2]
    ]) {
      translate(v=[p[0], fanThickness/2, p[1]])
      rotate(a=[90, 0, 0])
      cylinder(r=fanScrewR, h=fanThickness + 2, center=true, $fn=24);
    }
  }
}

module bridgeMountHoles() {
  for (p = cageMountCenters()) {
    translate(v=[p[0], p[1], -1])
    cylinder(r=cageMountR, h=bridgeZ + 2, $fn=24);
  }
}

module utilityShelfVentSlots(shelfW, shelfH) {
  for (z = [20:16:shelfH - 20]) {
    translate(v=[utilityT/2, shelfW/2, z])
    rotate(a=[0, 90, 0])
    roundedSlotXY(length=62, width=4, height=utilityT + 2);
  }
}

module drive25SideMountHoles() {
  for (y = [24, 24 + 61.72]) {
    for (z = [18, 18 + 76.6]) {
      translate(v=[utilityT/2, y, z])
      rotate(a=[0, 90, 0])
      cylinder(r=drive25ScrewR, h=utilityT + 2, center=true, $fn=24);
    }
  }
}

module buckSideMountHoles() {
  for (y = [86, 108]) {
    translate(v=[utilityT/2, y, 20])
    rotate(a=[0, 90, 0])
    cylinder(r=buckMountR, h=utilityT + 2, center=true, $fn=24);
  }
}

function driveSlotX(i) = hddBankX0 + hddSlotW/2 + i*hddPitch;
function hddSideScrewZs() = [
  for (offsetFromConnector = hddScrewOffsets)
  hddL - offsetFromConnector
];
function driveSlotBoundaryX(i) =
  i == 0 ? hddBankX0 :
  i == hddCount ? hddBankX0 + hddBankW :
  hddBankX0 + i*hddSlotW + (i - 0.5)*hddSlotGap;

function carrierInsertX0() = hddBankX0 - carrierSideMargin;
function carrierInsertY0() = hddY0 - carrierRailT - carrierDriveGapY;
function carrierSlotX(i) = carrierSideMargin + hddSlotW/2 + i*hddPitch;
function carrierAirflowSlotX(i) = (carrierSlotX(i - 1) + carrierSlotX(i)) / 2;
function carrierAirflowSlotXs() = [
  for (i = [1:hddCount - 1])
  carrierAirflowSlotX(i)
];
function driveCarrierTopClampMountCenters() = [
  for (x = [topClampMountInsetX, carrierInsertW - topClampMountInsetX])
  for (y = [topClampMountInsetY, carrierInsertD - topClampMountInsetY])
  [x, y]
];
function topClampFrontLegScrewLocalCenters() = [
  for (x = [tableLegW/2, outerW - tableLegW/2])
  [x - carrierInsertX0(), topClampFrontLipY0() + topClampLegLipT]
];
function topClampRearLegScrewLocalCenters() = [
  for (x = [tableLegW/2, outerW - tableLegW/2])
  [x - carrierInsertX0(), topClampRearLipY0()]
];
function topClampLegScrewLocalCenters() =
  concat(topClampFrontLegScrewLocalCenters(), topClampRearLegScrewLocalCenters());
function topClampFrontLipY0() =
  max(0, tableLegD - carrierInsertY0());
function topClampRearLipY0() =
  outerD - tableLegD - topClampLegLipT - carrierInsertY0();
function topClampPlateX0() =
  -carrierInsertX0();
function topClampPlateY0() =
  topClampFrontLipY0();
function topClampPlateW() =
  outerW;
function topClampPlateD() =
  topClampRearLipY0() + topClampLegLipT - topClampPlateY0();
function topClampLegLipX0() =
  -carrierInsertX0();
function topClampLegLipW() =
  outerW;
function topBraceDriveWindowY0() =
  hddY0 - carrierInsertY0() - 0.7;
function driveRetainerCenterY(i) =
  hddY0 - carrierInsertY0() + hddD - driveRetainerYFromRear
    - (i % 2) * driveRetainerYStagger;
function driveRetainerX0(i) =
  carrierSlotX(i) - driveRetainerW/2;
function driveRetainerY0(i) =
  driveRetainerCenterY(i) - driveRetainerD/2;
function driveRetainerLocalScrewCenters() = [
  [driveRetainerScrewEdge, driveRetainerD/2],
  [driveRetainerW - driveRetainerScrewEdge, driveRetainerD/2]
];
function driveRetainerScrewCenters(i) = [
  for (p = driveRetainerLocalScrewCenters())
  [driveRetainerX0(i) + p[0], driveRetainerY0(i) + p[1]]
];
function topClampLegScrewGlobalZ() =
  hddTopZ + topClampLegScrewZ;
function topClampNutPocketCenterZ() =
  hddL - topClampNutRoofT - (hexNutThickness("m3") + overhangSlack) / 2;
function carrierSlotBoundaryX(i) =
  i == 0 ? carrierSideMargin :
  i == hddCount ? carrierSideMargin + hddBankW :
  carrierSideMargin + i*hddSlotW + (i - 0.5)*hddSlotGap;
function driveRailX0(i) = driveSlotX(i) - driveRailW/2;
function driveRailY0() = hddY0 - driveRailT;
function accessPanelSlotXs() = [32:24:outerW - 32];

function frontRearPanelMountCenters() = [
  for (x = [tableLegW/2, outerW - tableLegW/2])
  for (z = frontRearPanelMountZs)
  [x, z]
];

function leftRightPanelMountCenters() = [
  for (y = [tableLegD/2, outerD - tableLegD/2])
  for (z = sidePanelMountZs)
  [y, z]
];

function pcCaseScrewCenters() = [
  [outerW/2 - pcCaseScrewPatternX/2, outerD/2 - pcCaseScrewPatternY/2],
  [outerW/2 + pcCaseScrewPatternX/2, outerD/2 - pcCaseScrewPatternY/2],
  [outerW/2 - pcCaseScrewPatternX/2, outerD/2 + pcCaseScrewPatternY/2],
  [outerW/2 + pcCaseScrewPatternX/2, outerD/2 + pcCaseScrewPatternY/2]
];

function cageMountCenters() = [
  [8, 8],
  [outerW - 8, 8],
  [8, outerD - 8],
  [outerW - 8, outerD - 8]
];

function carrierMountCenters() = [
  [carrierInsertX0() + carrierMountInsetX, carrierInsertY0() + carrierMountInsetY],
  [carrierInsertX0() + carrierInsertW - carrierMountInsetX, carrierInsertY0() + carrierMountInsetY],
  [carrierInsertX0() + carrierMountInsetX, carrierInsertY0() + carrierInsertD - carrierMountInsetY],
  [carrierInsertX0() + carrierInsertW - carrierMountInsetX, carrierInsertY0() + carrierInsertD - carrierMountInsetY]
];

function carrierMountLocalCenters() = [
  [carrierMountInsetX, carrierMountInsetY],
  [carrierInsertW - carrierMountInsetX, carrierMountInsetY],
  [carrierMountInsetX, carrierInsertD - carrierMountInsetY],
  [carrierInsertW - carrierMountInsetX, carrierInsertD - carrierMountInsetY]
];

function fanScrewCenters() = [
  [fanCenterX - fan120HoleSpacing/2, fanCenterZ - fan120HoleSpacing/2],
  [fanCenterX + fan120HoleSpacing/2, fanCenterZ - fan120HoleSpacing/2],
  [fanCenterX - fan120HoleSpacing/2, fanCenterZ + fan120HoleSpacing/2],
  [fanCenterX + fan120HoleSpacing/2, fanCenterZ + fan120HoleSpacing/2]
];

function nearAny(value, values, tolerance) =
  max([for (v = values) abs(value - v) <= tolerance ? 1 : 0]) == 1;

function distance2d(y1, z1, y2, z2) =
  sqrt((y1 - y2)*(y1 - y2) + (z1 - z2)*(z1 - z2));

module slotThroughY(length, r, depth) {
  hull() {
    translate(v=[-length/2, 0, 0])
    rotate(a=[90, 0, 0])
    cylinder(r=r, h=depth, center=true, $fn=24);

    translate(v=[length/2, 0, 0])
    rotate(a=[90, 0, 0])
    cylinder(r=r, h=depth, center=true, $fn=24);
  }
}

module verticalSlotThroughY(width, height, depth) {
  r = width/2;
  hull() {
    translate(v=[0, 0, -height/2 + r])
    rotate(a=[90, 0, 0])
    cylinder(r=r, h=depth, center=true, $fn=24);

    translate(v=[0, 0, height/2 - r])
    rotate(a=[90, 0, 0])
    cylinder(r=r, h=depth, center=true, $fn=24);
  }
}

module chamferedVerticalSlotThroughY(width, height, depth, chamfer, chamferDepth) {
  verticalSlotThroughY(width=width, height=height, depth=depth + 2);

  hull() {
    translate(v=[0, -depth/2 - 0.02, 0])
    verticalSlotThroughY(width=width + 2*chamfer, height=height + 2*chamfer, depth=0.04);

    translate(v=[0, -depth/2 + chamferDepth, 0])
    verticalSlotThroughY(width=width, height=height, depth=0.04);
  }

  hull() {
    translate(v=[0, depth/2 + 0.02, 0])
    verticalSlotThroughY(width=width + 2*chamfer, height=height + 2*chamfer, depth=0.04);

    translate(v=[0, depth/2 - chamferDepth, 0])
    verticalSlotThroughY(width=width, height=height, depth=0.04);
  }
}

module verticalSlotThroughX(width, height, depth) {
  r = width/2;
  hull() {
    translate(v=[0, 0, -height/2 + r])
    rotate(a=[0, 90, 0])
    cylinder(r=r, h=depth, center=true, $fn=24);

    translate(v=[0, 0, height/2 - r])
    rotate(a=[0, 90, 0])
    cylinder(r=r, h=depth, center=true, $fn=24);
  }
}

module chamferedVerticalSlotThroughX(width, height, depth, chamfer, chamferDepth) {
  verticalSlotThroughX(width=width, height=height, depth=depth + 2);

  hull() {
    translate(v=[-depth/2 - 0.02, 0, 0])
    verticalSlotThroughX(width=width + 2*chamfer, height=height + 2*chamfer, depth=0.04);

    translate(v=[-depth/2 + chamferDepth, 0, 0])
    verticalSlotThroughX(width=width, height=height, depth=0.04);
  }

  hull() {
    translate(v=[depth/2 + 0.02, 0, 0])
    verticalSlotThroughX(width=width + 2*chamfer, height=height + 2*chamfer, depth=0.04);

    translate(v=[depth/2 - chamferDepth, 0, 0])
    verticalSlotThroughX(width=width, height=height, depth=0.04);
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

module roundedRectOutsideCornerCutouts(width, depth, height, r) {
  safeR = min(r, min(width, depth)/2 - eps);

  cornerRoundCutout(
    x0=0,
    y0=0,
    cx=safeR,
    cy=safeR,
    height=height,
    r=safeR
  );

  cornerRoundCutout(
    x0=width - safeR,
    y0=0,
    cx=width - safeR,
    cy=safeR,
    height=height,
    r=safeR
  );

  cornerRoundCutout(
    x0=0,
    y0=depth - safeR,
    cx=safeR,
    cy=depth - safeR,
    height=height,
    r=safeR
  );

  cornerRoundCutout(
    x0=width - safeR,
    y0=depth - safeR,
    cx=width - safeR,
    cy=depth - safeR,
    height=height,
    r=safeR
  );
}

module cornerRoundCutout(x0, y0, cx, cy, height, r) {
  translate(v=[0, 0, -1])
  difference() {
    translate(v=[x0 - eps, y0 - eps, 0])
    cube(size=[r + 2*eps, r + 2*eps, height]);

    translate(v=[cx, cy, -1])
    cylinder(r=r, h=height + 2, $fn=48);
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

module roundedPanelYz(thickness, depth, height, r) {
  safeR = min(r, min(depth, height)/2 - eps);

  hull() {
    translate(v=[0, safeR, safeR])
    rotate(a=[0, 90, 0])
    cylinder(r=safeR, h=thickness, $fn=32);

    translate(v=[0, depth - safeR, safeR])
    rotate(a=[0, 90, 0])
    cylinder(r=safeR, h=thickness, $fn=32);

    translate(v=[0, safeR, height - safeR])
    rotate(a=[0, 90, 0])
    cylinder(r=safeR, h=thickness, $fn=32);

    translate(v=[0, depth - safeR, height - safeR])
    rotate(a=[0, 90, 0])
    cylinder(r=safeR, h=thickness, $fn=32);
  }
}

module roundedWindowThroughZ(width, depth, height, r) {
  safeR = min(r, min(width, depth)/2 - eps);

  hull() {
    translate(v=[-width/2 + safeR, -depth/2 + safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);

    translate(v=[width/2 - safeR, -depth/2 + safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);

    translate(v=[-width/2 + safeR, depth/2 - safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);

    translate(v=[width/2 - safeR, depth/2 - safeR, 0])
    cylinder(r=safeR, h=height, $fn=32);
  }
}

module roundedWindowThroughY(width, depth, height, r) {
  safeR = min(r, min(width, height)/2 - eps);

  hull() {
    translate(v=[-width/2 + safeR, 0, -height/2 + safeR])
    rotate(a=[90, 0, 0])
    cylinder(r=safeR, h=depth, center=true, $fn=32);

    translate(v=[width/2 - safeR, 0, -height/2 + safeR])
    rotate(a=[90, 0, 0])
    cylinder(r=safeR, h=depth, center=true, $fn=32);

    translate(v=[-width/2 + safeR, 0, height/2 - safeR])
    rotate(a=[90, 0, 0])
    cylinder(r=safeR, h=depth, center=true, $fn=32);

    translate(v=[width/2 - safeR, 0, height/2 - safeR])
    rotate(a=[90, 0, 0])
    cylinder(r=safeR, h=depth, center=true, $fn=32);
  }
}
