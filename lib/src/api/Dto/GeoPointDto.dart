
import 'package:json_annotation/json_annotation.dart';

part 'GeoPointDto.g.dart';

@JsonSerializable()
class GeoPointDto {
  GeoPointDto(this.lat, this.long);

  factory GeoPointDto.fromJson(Map<String, dynamic> json) =>
      _$GeoPointDtoFromJson(json);

  final double lat;
  final double long;

  Map<String, dynamic> toJson() => _$GeoPointDtoToJson(this);
}