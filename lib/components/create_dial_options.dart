import 'package:flutter/material.dart';
import 'package:timestamp_dial/components/dial.dart';

List<Widget> createDialOptions(
  Dial widget,
  Function calcAngle,
  String currentValue,
  BuildContext ctx,
) =>
    widget.options.asMap().entries.map((entry) {
      final index = entry.key;
      return Center(
        child: Transform.rotate(
          angle: calcAngle(index),
          child: Transform.translate(
            child: Text(
              entry.value,
              style: TextStyle(
                color: currentValue == entry.value
                    ? Colors.red[900]
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(ctx).size.height / 50,
              ),
            ),
            offset: Offset(0, widget.height / -2.2),
          ),
        ),
      );
    }).toList();
