
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mappin/src/api/ApiService.dart';
import 'package:mappin/src/api/Dto/GeoPointDto.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;

class MapViewModel {
  final ApiService apiService = ApiService();

  BehaviorSubject<bool> isLoading =
      BehaviorSubject<bool>.seeded(false, sync: true);
  BehaviorSubject<GeoPointDto> userLocation =
      BehaviorSubject<GeoPointDto>.seeded(null, sync: true);
  BehaviorSubject<List<PostDto>> posts =
      BehaviorSubject<List<PostDto>>.seeded(<PostDto>[], sync: true);
  BehaviorSubject<PostDto> currentPost =
      BehaviorSubject<PostDto>.seeded(null, sync: true);

  Future<void> getLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userLocation.add(GeoPointDto(position.latitude, position.longitude));
  }

  Future<void> getPosts(double lat, double long, int radius) async {
    isLoading.add(true);
    try {
      final List<PostDto> resp =
          await apiService.getPostByPosition(lat, long, radius);
      posts.add(resp);
    } on DioError catch (error) {
      print(error);
    }
    isLoading.add(false);
  }

  Future<map.BitmapDescriptor> getPostIcon(String imageUrl) async {
    const int targetWidth = 100;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(pictureRecorder);
    final ui.Paint paint = ui.Paint()..color;
    const double radius = targetWidth / 2;
    final File markerImageFile =
        await DefaultCacheManager().getSingleFile(imageUrl);
    final Uint8List markerImageBytes = await markerImageFile.readAsBytes();

    //make canvas clip path to prevent image drawing over the circle
    final ui.Path clipPath = ui.Path();
    clipPath.addRRect(ui.RRect.fromRectAndRadius(
        ui.Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetWidth.toDouble()),
        const ui.Radius.circular(radius)));
    canvas.clipPath(clipPath);

    //paintImage
    final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
      markerImageBytes,
      targetWidth: targetWidth,
    );
    final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect:
            ui.Rect.fromLTWH(0, 0, targetWidth.toDouble(), targetWidth.toDouble()),
        image: frameInfo.image);

    paint.color = Colors.white;
    paint.style = ui.PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawCircle(const Offset(radius, radius), radius, paint);

    //convert canvas as PNG bytes
    final ui.Image _image = await pictureRecorder
        .endRecording()
        .toImage(targetWidth, (targetWidth * 1.1).toInt());
    final ByteData data =
        await _image.toByteData(format: ui.ImageByteFormat.png);

    //convert PNG bytes as BitmapDescriptor
    return map.BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}
