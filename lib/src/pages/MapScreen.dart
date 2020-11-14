import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
          child: Hero(
            tag: "test",
            child: FlatButton(
              child: Text("Test"),
              onPressed: () {
                Navigator.of(context, rootNavigator: false)
                    .pushNamed("/postDetail");
              },
            ),
          ),
        ));
  }
}
