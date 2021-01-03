import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;
import 'package:mappin/src/api/Dto/PostDto.dart';

import 'package:mappin/src/values/colors.dart' as colors;
import 'package:mappin/src/widgets/platforms/PlatformProgress.dart';

class DetailPostMap extends StatelessWidget {
  const DetailPostMap({
    Key key,
    @required Completer<map.GoogleMapController> controllerMap,
    @required PostDto currentPost,
  })  : _controllerMap = controllerMap,
        _currentPost = currentPost,
        super(key: key);

  final Completer<map.GoogleMapController> _controllerMap;
  final PostDto _currentPost;

  @override
  Widget build(BuildContext context) {
    map.CameraPosition camPos;
    final Set<map.Marker> markers = HashSet<map.Marker>();
    if (_currentPost != null) {
      camPos = map.CameraPosition(
        target:
            map.LatLng(_currentPost.position.lat, _currentPost.position.long),
        zoom: 10,
      );
      markers.add(
        map.Marker(
          markerId: map.MarkerId(_currentPost.id),
          position:
              map.LatLng(_currentPost.position.lat, _currentPost.position.long),
        ),
      );
    }
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(left: 5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colors.accentColor,
      ),
      child: _currentPost == null
          ? AnimatedOpacity(
              opacity: 0.6,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: colors.smoothLabelColor,
                ),
                padding: const EdgeInsets.all(5),
                child: PlatformProgress(
                  isAnimating: true,
                ),
              ),
            )
          : map.GoogleMap(
              mapType: map.MapType.normal,
              initialCameraPosition: camPos,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              markers: markers,
              onMapCreated: (map.GoogleMapController controller) {
                _controllerMap.complete(controller);
              },
            ),
    );
  }
}
