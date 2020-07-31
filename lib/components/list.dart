import 'package:flutter/material.dart';

Container Function(BuildContext) list = (context) => Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: List.generate(
          1000,
          (index) => Text('$index'),
        ),
      ),
    );
