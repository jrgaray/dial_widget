import 'package:timestamp_dial/components/dial.dart';
import 'package:flutter/material.dart';
import 'package:timestamp_dial/components/appbar.dart';
import 'package:timestamp_dial/components/list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double hourDial = 0;
  double minuteDial = 0;
  double amPMDial = 0;

  List<String> buildOptions(int start, int end) {
    List<String> options = [];
    for (int i = start; i < end + 1; i++) {
      options.add(i.toString());
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    final knobSet = (double height) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Dial(
            height: height,
            color: Colors.blue,
            options: buildOptions(1, 12),
          ),
          Dial(
            height: height / 1.4,
            color: Colors.yellow,
            options: buildOptions(0, 59),
          ),
          Dial(
            height: height / 1.6,
            color: Colors.red,
            options: ['AM', 'PM'],
          ),
          MaterialButton(
            shape: CircleBorder(),
            height: height / 1.8,
            minWidth: MediaQuery.of(context).size.width,
            color: Colors.green,
            onPressed: () => print('hi'),
          ),
        ],
      );
    };
    final screenSize = MediaQuery.of(context).size.height;
    final yOffset = screenSize > 500 ? 500.0 : screenSize;
    return Scaffold(
      appBar: appBar(widget),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 250),
              child: list(context),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height,
              child: Transform.translate(
                offset: Offset(0, yOffset),
                child: Transform.scale(
                  scale: 3,
                  child: knobSet(screenSize > 500 ? 500.0 : screenSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
