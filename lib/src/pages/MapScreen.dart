import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  AnimationController _controllerLottie;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    _controllerLottie = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controllerLottie.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              top: 100,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  _controllerLottie.forward();
                },
                child: SizedBox(
                  width: 100,
                  height: 30,
                  child: Lottie.asset(
                    'assets/animations/focus_animation.json',
                    controller: _controllerLottie,
                    onLoaded: (composition) {
                      _controllerLottie.duration = composition.duration;
                      _controllerLottie.addStatusListener((status) {
                        if (status == AnimationStatus.completed) {
                          _controllerLottie.reset();
                        }
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // body: Center(
      //   child: Hero(
      //     tag: "test",
      //     child: FlatButton(
      //       child: Text("Test"),
      //       onPressed: () {
      //         Navigator.of(context, rootNavigator: false)
      //             .pushNamed("/postDetail");
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
