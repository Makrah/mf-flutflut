import 'dart:convert';

import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mappin/MyAvatar.dart';
import 'package:mappin/SecondScreen.dart';
import 'package:mappin/main.dart';
import 'package:http/http.dart' as http;
import 'package:mappin/src/values/enums.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool _isAff = false;
  String _position = "Waiting...";
  Counter counter = getIt.get<Counter>();

  void checkPermissions() async {
    print("------------------>B");
    LocationPermission currentPermission = await Geolocator.checkPermission();
    print("------------------>C");
    if (currentPermission == LocationPermission.always ||
        currentPermission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String positionText = await http.read(
          "https://api-adresse.data.gouv.fr/search/?q=8+bd+du+port&lat=48.789&lon=2.789");
      dynamic positionTextJson = jsonDecode(positionText);
      setState(() {
        _position =
            positionTextJson["features"][0]["properties"]["label"] as String;
      });
      print("------------------>D");
    } else {
      print("------------------>G");
      LocationPermission permission = await Geolocator.requestPermission();
      print("------------------>E");
    }
  }

  @override
  void initState() {
    super.initState();
    print("------------------>A");
    // counter.login();
    counter.getUserMe();
    counter.loginState.stream.listen((event) {
      if (event == LoginState.success) {
        // Navigator.pushNamed(context, "/second");
      } else if (event == LoginState.error) {
        EdgeAlert.show(context,
            title: 'Erreur',
            description: 'Identifiants invalids',
            gravity: EdgeAlert.TOP);
      }
    });
    // checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        children: [
          MyAvatar(),
          StreamBuilder(
              stream: counter.username.stream,
              builder: (BuildContext context, AsyncSnapshot snap) {
                return Text('${snap.data}');
              }),
          Text(_position),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/second");
            },
            child: Text("Navigate"),
          ),
          Text(
            "Cyril chaillan",
            style: TextStyle(
                color: Colors.red, fontSize: 40, fontFamily: "Pacifico"),
          ),
          Text(
            "Dev",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
            width: 150,
            child: Divider(
              color: Colors.red,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text("06 06 0 60 607"),
            ),
          ),
        ],
      ),
    );
  }
}
