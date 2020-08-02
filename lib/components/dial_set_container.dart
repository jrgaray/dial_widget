import 'package:flutter/material.dart';

final dialSetContainer =
    (BuildContext context, double yOffset, Widget child) => Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Transform.translate(
            offset: Offset(0, yOffset / 1.3),
            child: Transform.scale(
              scale: MediaQuery.of(context).size.height > 500 ? 1.5 : 2.5,
              child: child,
            ),
          ),
        );
