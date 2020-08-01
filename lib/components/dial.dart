import 'package:flutter/material.dart';
import 'package:timestamp_dial/helper/calculateRotationalChange.dart';
import 'dart:math';

class Dial extends StatefulWidget {
  Dial(
      {Key key,
      this.height,
      this.options,
      this.color,
      this.value,
      this.onChange})
      : super(key: key);

  final double height;
  final List options;
  final Color color;
  final String value;
  final Function(String) onChange;

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
    final modAngle = ((angle + 0.000001) % tick);
    final roundingMod = modAngle > halfTick ? 1 : 0;
    setState(() => angle = ((angle / tick).floor() + roundingMod) * tick);
    final newValueIndex = (angle / tick).abs().floor();
    widget.onChange(widget.options[newValueIndex]);
  }

  double calcAngle(int index) => angle + index * tick;

  @override
  Widget build(BuildContext context) {
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
                angle: calcAngle(index),
                child: Transform.translate(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  offset: Offset(0, widget.height / -2.0 + 20),
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
