// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeoPointDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoPointDto _$GeoPointDtoFromJson(Map<String, dynamic> json) {
  return GeoPointDto(
    (json['lat'] as num)?.toDouble(),
    (json['long'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$GeoPointDtoToJson(GeoPointDto instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };
