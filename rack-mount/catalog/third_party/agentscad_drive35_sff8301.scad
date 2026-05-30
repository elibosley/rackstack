/*
 * Derived from AgentSCAD electronic.scad by Gilles Bouissac.
 *
 * Original copyright notice:
 * Copyright (c) 2020, Gilles Bouissac
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *   * Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright notice,
 *     this list of conditions and the following disclaimer in the documentation
 *     and/or other materials provided with the distribution.
 *
 * This local helper keeps only the SFF-8301 3.5 in drive dimensions needed by
 * the NAS shell prototype, so the rackstack repo does not need the full
 * AgentSCAD dependency tree.
 */

function drive35_inch(v) = v * 25.4;

// SFF-8301 3.5 in drive envelope, converted from the AgentSCAD data table.
function drive35_length() = drive35_inch(5.787);
function drive35_width() = drive35_inch(4.0);
function drive35_height_common() = drive35_inch(1.028);

// UNC #6-32 thread data from the AgentSCAD SFF-8301 table.
function drive35_thread_diameter() = drive35_inch(0.138);
function drive35_thread_pitch() = drive35_inch(1 / 32);
function drive35_thread_clearance_radius(slack=0.3) =
  drive35_thread_diameter() / 2 + slack;

// Side mounting holes along the drive length. AgentSCAD labels these as
// SFF8301 A8 and A8+A9.
function drive35_side_hole_offsets_from_connector_end() = [
  drive35_inch(1.122),
  drive35_inch(1.122 + 4.0)
];

function drive35_side_hole_center_height_from_bottom() = drive35_inch(0.250);

// Common SFF-8301 bottom mounting pattern, measured from the connector end and
// centered across the 4 in drive width. These are for tray/sled mounting.
function drive35_bottom_hole_offsets_from_connector_end() = [
  drive35_inch(0.250),
  drive35_inch(0.250 + 3.750)
];

function drive35_bottom_hole_offsets_from_centerline() = [
  -drive35_inch(1.75),
  drive35_inch(1.75)
];

// Conservative service keepout for SATA data + power plug access at the
// connector end. This is intentionally larger than the bare connector pair so
// printed clamps do not block common straight or low-profile plug housings.
function drive35_sata_connector_keepout_height() = drive35_height_common() - 0.18 * 25.4;
function drive35_sata_connector_keepout_width() = drive35_inch(2.85);
function drive35_sata_connector_keepout_offset_from_side() =
  (drive35_width() - drive35_sata_connector_keepout_width()) / 2;

module drive35_reference_model(
  show_side_mounts=true,
  show_bottom_mounts=true,
  show_connector_keepout=true
) {
  bodyR = 1.8;
  connectorD = 3.5;
  screwR = drive35_thread_clearance_radius(0.15);

  color([0.42, 0.43, 0.42, 0.44])
  difference() {
    roundedDriveEnvelope(r=bodyR);

    if (show_side_mounts) {
      drive35_side_mount_holes(r=screwR, depth=drive35_width() + 2);
    }

    if (show_bottom_mounts) {
      drive35_bottom_mount_holes(r=screwR, depth=drive35_height_common() + 2);
    }
  }

  if (show_connector_keepout) {
    color([0.10, 0.10, 0.10, 0.78])
    translate(v=[
      drive35_length() - connectorD,
      drive35_sata_connector_keepout_offset_from_side(),
      3.2
    ])
    cube(size=[
      connectorD,
      drive35_sata_connector_keepout_width(),
      drive35_sata_connector_keepout_height()
    ]);
  }
}

module drive35_side_mount_holes(r=drive35_thread_clearance_radius(), depth=drive35_width() + 2) {
  for (x = drive35_side_hole_x_positions()) {
    translate(v=[x, drive35_width()/2, drive35_side_hole_center_height_from_bottom()])
    rotate(a=[90, 0, 0])
    cylinder(r=r, h=depth, center=true, $fn=32);
  }
}

module drive35_bottom_mount_holes(r=drive35_thread_clearance_radius(), depth=drive35_height_common() + 2) {
  for (x = drive35_bottom_hole_x_positions()) {
    for (y = drive35_bottom_hole_y_positions()) {
      translate(v=[x, y, -1])
      cylinder(r=r, h=depth, $fn=32);
    }
  }
}

function drive35_side_hole_x_positions() = [
  for (offsetFromConnector = drive35_side_hole_offsets_from_connector_end())
  drive35_length() - offsetFromConnector
];

function drive35_bottom_hole_x_positions() = [
  for (offsetFromConnector = drive35_bottom_hole_offsets_from_connector_end())
  drive35_length() - offsetFromConnector
];

function drive35_bottom_hole_y_positions() = [
  for (offsetFromCenterline = drive35_bottom_hole_offsets_from_centerline())
  drive35_width()/2 + offsetFromCenterline
];

module roundedDriveEnvelope(r) {
  hull() {
    for (x = [r, drive35_length() - r]) {
      for (y = [r, drive35_width() - r]) {
        for (z = [r, drive35_height_common() - r]) {
          translate(v=[x, y, z])
          sphere(r=r, $fn=24);
        }
      }
    }
  }
}
