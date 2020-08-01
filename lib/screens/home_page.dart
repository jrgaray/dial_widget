import 'package:timestamp_dial/components/dial.dart';
import 'package:flutter/material.dart';
import 'package:timestamp_dial/components/appbar.dart';
import 'package:timestamp_dial/components/list.dart';
import 'package:timestamp_dial/helper/buildOptions.dart';
import 'package:timestamp_dial/components/dial_set_container.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // State Variables
  List<String> timestamps;
  String hour;
  List<String> hourOptions;
  String minute;
  List<String> minuteOptions;
  String amPM;
  List<String> amPMOptions;

  // Initialize the the options that will be passed into the dial components,
  // and the starting state of the timestamps.
  @override
  void initState() {
    super.initState();
    hourOptions = buildOptions(1, 12);
    minuteOptions = buildOptions(0, 59);
    amPMOptions = ["AM", "PM"];
    hour = hourOptions[0];
    timestamps = [];
    minute = minuteOptions[0];
    amPM = amPMOptions[0];
  }

  // State handlers
  void hourHandler(value) => setState(() => hour = value);
  void minuteHandler(value) => setState(() => minute = value);
  void amPMHandler(value) => setState(() => amPM = value);
  void handleClick() => setState(() => timestamps.add('$hour:$minute $amPM'));

  @override
  Widget build(BuildContext context) {
    // Set of dials and button. Essentially a form.
    final dialSet = (double height, Function handleClick) {
      // Calculation functions.
      double calcHeight(double factor) => height * factor;
      double calcFontSize(double factor) => height / factor;

      return Stack(
        alignment: Alignment.center,
        children: [
          Dial(
            value: hour,
            onChange: hourHandler,
            height: calcHeight(.5),
            color: Colors.blue,
            options: hourOptions,
          ),
          Dial(
            value: minute,
            onChange: minuteHandler,
            height: calcHeight(0.4),
            color: Colors.yellow,
            options: minuteOptions,
          ),
          Dial(
            limit: true,
            value: amPM,
            onChange: amPMHandler,
            height: calcHeight(0.3),
            color: Colors.red,
            options: amPMOptions,
          ),
          // Used the following as a resource to create the Button:
          // https://stackoverflow.com/questions/49809351/how-to-create-a-circle-icon-button-in-flutter/55406627
          ClipOval(
            child: Material(
              color: Colors.green, // button color
              child: InkWell(
                splashColor: Colors.white, // inkwell color
                child: SizedBox(
                  width: calcHeight(.2),
                  height: calcHeight(.2),
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(0, calcHeight(-0.05)),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: calcFontSize(25),
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () => handleClick(),
              ),
            ),
          ),
        ],
      );
    };

    // Calculate a relative height.
    final height = MediaQuery.of(context).size.height / 2.0;

    return Scaffold(
      appBar: appBar(widget),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // List where the timestamps live.
            timestampList(context, timestamps),
            // Container for the dials.
            dialSetContainer(
              context,
              height,
              // Set of dial inputs.
              dialSet(height, handleClick),
            ),
          ],
        ),
      ),
    );
  }
}
