import 'package:flutter/material.dart';
import 'package:timestamp_dial/helper/calculateRotationalChange.dart';
import 'dart:math';

class Dial extends StatefulWidget {
  Dial({Key key, this.height, this.options, this.color}) : super(key: key);

  final double height;
  final List options;
  final Color color;

  @override
  _DialState createState() => _DialState();
}

class _DialState extends State<Dial> {
  double height;
  double radian = 2 * pi;
  double angle = 0;
  int slices;
  double tick;
  double halfTick;
  int optionsLength;

// Calculated based on options
  @override
  void initState() {
    super.initState();
    slices = widget.options.length > 11 ? widget.options.length : 30;
    print(slices);
    tick = radian / slices;
    halfTick = tick / 2;
    optionsLength = widget.options.length;
    height = widget.height;
  }

  void _panHandler(DragUpdateDetails d, int size, double radius) {
    double rotationalChange = calculateRotationalChange(d, radius);

    final isMovementClockwise = rotationalChange > 0;
    final isMovementCounterClockwise = rotationalChange < 0;

    final lowerLimit = 0;
    final upperLimit = -tick * (optionsLength - 1);

    final isAngleWithinLowerLimit = angle <= lowerLimit;
    final isAngleWithinUpperLimit = angle > upperLimit;

    setState(() {
      if (isMovementClockwise && isAngleWithinLowerLimit)
        angle += radian / 360;
      else if (isMovementCounterClockwise && isAngleWithinUpperLimit)
        angle -= radian / 360;
      else
        return;
    });
  }

  void _panEndHandler(DragEndDetails d, int size) {
    final modAngle = (angle % tick);

    setState(() {
      if (modAngle >= halfTick) {
        angle = ((angle / tick).floor() + 1) * tick;
      } else {
        angle = (angle / tick).floor() * tick;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final add = widget.height > 400 ? 0.0 : 35.0;
    return GestureDetector(
      onPanEnd: (details) => _panEndHandler(details, optionsLength),
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
          children: widget.options.asMap().entries.map((entry) {
            final index = entry.key;
            return Center(
              child: Transform.rotate(
                angle: angle + tick * index,
                child: Transform.translate(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  offset: Offset(0, widget.height / -2.7 - add),
                ),
              ),
            );
          }).toList(),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
        ),
      ),
    );
  }
}