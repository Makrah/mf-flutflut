import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:lottie/lottie.dart';
import 'package:mappin/src/api/Dto/GeoPointDto.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:mappin/src/viewModels/MapViewModel.dart';
import 'package:mappin/src/widgets/DisposableWidget.dart';
import 'package:mappin/src/widgets/map/MapCardWidget.dart';
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';
import 'package:mappin/src/widgets/platforms/PlatformScaffold.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  static const String routeName = '/map';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with TickerProviderStateMixin, DisposableWidget {
  final Completer<map.GoogleMapController> _controllerMap =
      Completer<map.GoogleMapController>();
  Set<map.Marker> _markers = HashSet<map.Marker>();
  final MapViewModel _mapViewModel = MapViewModel();
  AnimationController _controllerLottie;

  static const map.CameraPosition _kGooglePlex = map.CameraPosition(
    target: map.LatLng(43.240644, 5.406952),
    zoom: 8,
  );

  Future<void> _onRegionChanged() async {
    final map.GoogleMapController mapRef = await _controllerMap.future;
    final double zoom = await mapRef.getZoomLevel();
    final int radius = math.pow(21 - zoom, 2.5).toInt();
    final double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    final double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    final double middleX = screenWidth / 2;
    final double middleY = screenHeight / 2;
    final map.ScreenCoordinate screenCoordinate =
        map.ScreenCoordinate(x: middleX.round(), y: middleY.round());
    final map.LatLng middlePoint = await mapRef.getLatLng(screenCoordinate);
    _mapViewModel.getPosts(middlePoint.latitude, middlePoint.longitude, radius);
  }

  Future<void> _focusOnUserTapped() async {
    final GeoPointDto userLoc = _mapViewModel.userLocation.value;
    if (userLoc != null) {
      final map.GoogleMapController mapRef = await _controllerMap.future;
      mapRef.animateCamera(
        map.CameraUpdate.newCameraPosition(
          map.CameraPosition(
              target: map.LatLng(userLoc.lat, userLoc.long), zoom: 12),
        ),
      );
    }
  }

  Future<void> _initUserLocation() async {
    await _mapViewModel.getLocation();
    _focusOnUserTapped();
  }

  @override
  void initState() {
    super.initState();

    _controllerLottie = AnimationController(vsync: this);
    _initUserLocation();
    _mapViewModel.posts.stream.listen((List<PostDto> event) async {
      // todo -> mettre la bonne image
      final List<map.Marker> tmpMarkers = await Future.wait(
        event.map(
          (PostDto e) async => map.Marker(
            markerId: map.MarkerId(e.id),
            position: map.LatLng(e.position.lat, e.position.long),
            icon: await _mapViewModel.getPostIcon('https://picsum.photos/1000'),
            onTap: () {
              _mapViewModel.currentPost.add(e);
            },
          ),
        ),
      );
      setState(() {
        _markers = tmpMarkers.toSet();
      });
    }).canceledBy(this);
    _mapViewModel.getPosts(43.240644, 5.406952, 4);
  }

  @override
  void dispose() {
    _controllerLottie.dispose();
    cancelSubscriptions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            map.GoogleMap(
              mapType: map.MapType.normal,
              initialCameraPosition: _kGooglePlex,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              onCameraIdle: () {
                _onRegionChanged();
              },
              markers: _markers,
              onMapCreated: (map.GoogleMapController controller) {
                _controllerMap.complete(controller);
              },
            ),
            SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // _mapViewModel.getPosts(43.240644, 5.406952, 4);
                            _controllerLottie.forward();
                            _focusOnUserTapped();
                          },
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Lottie.asset(
                              'assets/animations/focus_animation.json',
                              controller: _controllerLottie,
                              onLoaded: (LottieComposition composition) {
                                _controllerLottie.duration =
                                    composition.duration;
                                _controllerLottie.addStatusListener(
                                    (AnimationStatus status) {
                                  if (status == AnimationStatus.completed) {
                                    _controllerLottie.reset();
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: StreamBuilder<bool>(
                              stream: _mapViewModel.isLoading.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> snapshot) {
                                return PlatformProgress(
                                  isAnimating: snapshot.data,
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    height: 200,
                    child: StreamBuilder<PostDto>(
                        stream: _mapViewModel.currentPost.stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<PostDto> snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox.shrink();
                          }
                          return MapCardWidget(
                            mapViewModel: _mapViewModel,
                            currentPost: snapshot.data,
                          );
                        }),
                  ),
                ],
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
