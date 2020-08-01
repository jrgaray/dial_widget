import 'package:flutter/material.dart';

// ListView where timestamps live.
Widget Function(BuildContext, List) timestampList =
    (context, timestamps) => Padding(
          padding: EdgeInsets.only(bottom: 250),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: timestamps.map((timestamp) => Text(timestamp)).toList(),
            ),
          ),
        );
