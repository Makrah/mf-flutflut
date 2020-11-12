import 'package:json_annotation/json_annotation.dart';
import 'package:testApp/src/api/Dto/GeoPointDto.dart';

part 'PostDto.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePostDto {
  final String image;
  final String title;
  final String description;
  final GeoPointDto position;

  CreatePostDto(this.image, this.title, this.description, this.position);

  Map<String, dynamic> toJson() => _$CreatePostDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostDto {
  final String image;
  final String title;
  final String description;
  final GeoPointDto position;

  PostDto(this.image, this.title, this.description, this.position);

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PostDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostResponseDto {
  final PostDto post;

  PostResponseDto(this.post);

  factory PostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PostResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PostResponseDtoToJson(this);
}

@JsonSerializable()
class PostAuthorDto {
  final String id;
  final String username;
  final String image;

  PostAuthorDto(this.id, this.username, this.image);

  factory PostAuthorDto.fromJson(Map<String, dynamic> json) =>
      _$PostAuthorDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PostAuthorDtoToJson(this);
}
