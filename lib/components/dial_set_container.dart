import 'package:flutter/material.dart';

final dialSetContainer =
    (BuildContext context, double yOffset, Widget child) => Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Transform.translate(
            offset: Offset(0, yOffset / 1.3),
            child: Transform.scale(
              scale: 1.2,
              child: child,
            ),
          ),
        );
