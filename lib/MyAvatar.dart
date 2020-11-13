import 'package:flutter/material.dart';
import 'package:mappin/main.dart';

class MyAvatar extends StatefulWidget {
  MyAvatar({Key key}) : super(key: key);

  @override
  _MyAvatarState createState() => _MyAvatarState();
}

class _MyAvatarState extends State<MyAvatar> {
  String _imagePath = "a";
  Counter counter = getIt.get<Counter>();

  _changeAvatar() {
    counter.count.add(counter.count.value + 1);
    setState(() {
      _imagePath = _imagePath == "a" ? "b" : "a";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: _changeAvatar,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/pic_$_imagePath.jpg'),
        ));
  }
}
