import 'package:flutter/material.dart';
import 'package:timestamp_dial/components/dial_set.dart';
import 'package:timestamp_dial/components/list.dart';
import 'package:timestamp_dial/helper/buildOptions.dart';
import 'package:timestamp_dial/components/dial_set_container.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
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
    // Calculate a relative height.
    final screenHeight = MediaQuery.of(context).size.height;
    final dialHeight = screenHeight / 2.0;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        height: screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // List where the timestamps live.
            timestampList(context, timestamps),
            // Container for the dials.
            Builder(
              builder: (context) => dialSetContainer(
                context,
                dialHeight,
                // Set of dial inputs.
                dialSet(dialHeight, handleClick, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
