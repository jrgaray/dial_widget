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
  List<String> timestamps;
  String hour;
  List<String> hourOptions;
  String minute;
  List<String> minuteOptions;
  String amPM;
  List<String> amPMOptions;
  // @override
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

  void hourHandler(value) => setState(() => hour = value);
  void minuteHandler(value) => setState(() => minute = value);
  void amPMHandler(value) => setState(() => amPM = value);

  void handleClick() {
    setState(() {
      timestamps.add('$hour:$minute $amPM');
    });
  }

  @override
  Widget build(BuildContext context) {
    final dialSet = (double height, Function handleClick) {
      final radius = height / 2;
      double calc(double factor) => radius * factor * 2;

      return Stack(
        alignment: Alignment.center,
        children: [
          Dial(
            value: hour,
            onChange: hourHandler,
            height: calc(1.0),
            color: Colors.blue,
            options: hourOptions,
          ),
          Dial(
            value: minute,
            onChange: minuteHandler,
            height: calc(0.8),
            color: Colors.yellow,
            options: minuteOptions,
          ),
          Dial(
            value: amPM,
            onChange: amPMHandler,
            height: calc(0.6),
            color: Colors.red,
            options: amPMOptions,
          ),
          ClipOval(
            child: Material(
              color: Colors.green, // button color
              child: InkWell(
                splashColor: Colors.white, // inkwell color
                child: SizedBox(
                  width: calc(.4),
                  height: calc(.4),
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(0, -50),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                onTap: () => handleClick(),
              ),
            ),
          ),
          // MaterialButton(
          //   shape: CircleBorder(),
          //   height: calc(0.55),
          //   elevation: 2.0,
          //   // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   minWidth: calc(0.55),
          //   color: Colors.green,
          //   onPressed: () => handleClick(),
          // ),
        ],
      );
    };
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final yOffset = screenHeight > 500 ? screenWidth : screenHeight;

    return Scaffold(
      appBar: appBar(widget),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            timestampList(context, timestamps),
            dialSetContainer(
              context,
              yOffset,
              dialSet(yOffset, handleClick),
            ),
          ],
        ),
      ),
    );
  }
}
