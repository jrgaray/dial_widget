import 'package:flutter/material.dart';

final dialSetContainer =
    (BuildContext context, double yOffset, Widget child) => Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height,
          width: yOffset,
          child: Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.height / 3),
            child: Transform.scale(
              scale: 1.8,
              child: child,
            ),
          ),
        );
