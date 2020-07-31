import 'package:flutter/material.dart';

// Found this resource to calculate the rotational change.
// https://fireship.io/lessons/flutter-ipod/
double calculateRotationalChange(DragUpdateDetails d, double radius) {
  /// Pan location on the wheel
  bool onTop = d.localPosition.dy <= radius;
  bool onLeftSide = d.localPosition.dx <= radius;
  bool onRightSide = !onLeftSide;
  bool onBottom = !onTop;

  /// Pan movements
  bool panUp = d.delta.dy <= 0.0;
  bool panLeft = d.delta.dx <= 0.0;
  bool panRight = !panLeft;
  bool panDown = !panUp;

  /// Absoulte change on axis
  double yChange = d.delta.dy.abs();
  double xChange = d.delta.dx.abs();

  /// Directional change on wheel
  double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
      ? yChange
      : yChange * -1;

  double horizontalRotation =
      (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

  // Total computed change
  double rotationalChange =
      (verticalRotation + horizontalRotation) * (d.delta.distance * 0.2);
  return rotationalChange;
}
