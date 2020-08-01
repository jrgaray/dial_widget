import 'package:flutter/material.dart';
import 'package:timestamp_dial/helper/calculateRotationalChange.dart';
import 'package:timestamp_dial/components/create_dial_options.dart';
import 'dart:math';

class Dial extends StatefulWidget {
  Dial({
    Key key,
    this.height = 500,
    this.options = const [],
    this.color = Colors.blue,
    this.value,
    this.onChange,
    this.limit = false,
  }) : super(key: key);

  final double height;
  final List options;
  final Color color;
  final String value;
  final bool limit;
  final Function(String) onChange;

  @override
  _DialState createState() => _DialState();
}

class _DialState extends State<Dial> {
  static const double radian = 2 * pi;
  // Dial variables.
  // angle is used to track the the rotation of the dial in radians.
  // slices is the number of sections the dial will have.
  // tick is length of one slice.
  // halfTick is half the length of one slice.
  // optionsLength is the number of options.
  double angle;
  int slices;
  double tick;
  double halfTick;
  int optionsLength;
  double lowerLimit;
  double upperLimit;

  // init all of the above variables.
  @override
  void initState() {
    super.initState();
    angle = 0;
    slices = widget.options.length > 11 ? widget.options.length : 30;
    tick = radian / slices;
    halfTick = tick / 2;
    optionsLength = widget.options.length;
    lowerLimit = 0.0;
    upperLimit = -tick * (optionsLength - 1);
  }

  // Calculate which slice is closest to the current angle.
  int calculateClosestSlice() {
    // mod angle by tick. Additionally, add a small modifier to angle
    // to prevent snapping to an unexpected value.
    final modAngle = ((angle + 0.000001) % tick);
    final roundingMod = modAngle > halfTick ? 1 : 0;
    return (angle / tick).floor() + roundingMod;
  }

  // Helper to calculate angle based on index.
  double calcAngle(int index) => angle + index * tick;

  // Set the angle to the input slice.
  void snapDialToValue(slice) => setState(() => angle = slice * tick);

  // Panning handler.
  void _panHandler(DragUpdateDetails d, int size, double radius) {
    // Get the change in rotation. Look at function for resource link.
    double rotationalChange = calculateRotationalChange(d, radius);

    // Movement checks.
    final isMovementClockwise = rotationalChange > 0;
    final isMovementCounterClockwise = rotationalChange < 0;

    // Check if angle is within limits. If the limit variable was not defined,
    // disable limits.
    final isAngleWithinLowerLimit = widget.limit ? angle <= lowerLimit : true;
    final isAngleWithinUpperLimit = widget.limit ? angle > upperLimit : true;

    // Change angle depending on movement.
    setState(() {
      if (isMovementClockwise && isAngleWithinLowerLimit)
        angle += radian / 360;
      else if (isMovementCounterClockwise && isAngleWithinUpperLimit)
        angle -= radian / 360;
      else
        return;
    });
  }

  // At the end of movement, set angle to the angle of the closest value,
  // and change the option.
  void _panEndHandler() {
    int newSlice = calculateClosestSlice();
    snapDialToValue(newSlice);
    int newValueIndex = (-newSlice % slices).abs();
    widget.onChange(widget.options[newValueIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) => _panEndHandler(),
      onPanUpdate: (details) {
        _panHandler(
          details,
          optionsLength,
          widget.height / 2.0,
        );
      },
      child: Container(
        height: widget.height,
        width: widget.height,
        child: Stack(
          children: createDialOptions(widget, calcAngle),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
      ),
    );
  }
}
