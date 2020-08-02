import 'package:flutter/material.dart';
import 'package:timestamp_dial/components/dial.dart';
import 'package:timestamp_dial/screens/home_page.dart';

// Set of dials and button. Essentially a form.
Stack Function(double, Function, BuildContext) dialSet =
    (double height, Function handleClick, BuildContext context) {
  // Calculation functions.
  double calcHeight(double factor) => height * factor;
  double calcFontSize(double factor) => height / factor;

  MyHomePageState state = context.findAncestorStateOfType<MyHomePageState>();

  return Stack(
    alignment: Alignment.center,
    children: [
      Dial(
        value: state.hour,
        onChange: state.hourHandler,
        height: calcHeight(1.5),
        color: Colors.grey[400],
        options: state.hourOptions,
      ),
      Dial(
        value: state.minute,
        onChange: state.minuteHandler,
        height: calcHeight(1.2),
        color: Colors.grey[400],
        options: state.minuteOptions,
      ),
      Dial(
        limit: true,
        value: state.amPM,
        onChange: state.amPMHandler,
        height: calcHeight(0.9),
        color: Colors.grey[400],
        options: state.amPMOptions,
      ),
      Material(
        color: Colors.red,
        shadowColor: Colors.black,
        elevation: 20,
        borderRadius: BorderRadius.circular(calcHeight(0.75) / 2),
        child: MaterialButton(
          onPressed: () => handleClick(),
          height: calcHeight(0.6),
          minWidth: calcHeight(0.6),
          child: Transform.translate(
            offset: Offset(0, calcHeight(-0.1)),
            child: Text(
              'SAVE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: calcFontSize(10),
              ),
            ),
          ),
        ),
      ),
    ],
  );
};
