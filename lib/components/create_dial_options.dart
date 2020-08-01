import 'package:flutter/material.dart';
import 'package:timestamp_dial/components/dial.dart';

List<Widget> createDialOptions(Dial widget, Function calcAngle) =>
    widget.options.asMap().entries.map((entry) {
      final index = entry.key;
      return Center(
        child: Transform.rotate(
          angle: calcAngle(index),
          child: Transform.translate(
            child: Text(
              entry.value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: widget.height / 30,
              ),
            ),
            offset: Offset(0, widget.height / -2.2),
          ),
        ),
      );
    }).toList();
