import 'package:json_annotation/json_annotation.dart';
import 'package:mappin/src/api/Dto/GeoPointDto.dart';

part 'PostDto.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatePostDto {
  CreatePostDto(this.image, this.title, this.description, this.position);
  factory CreatePostDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePostDtoFromJson(json);

  final String image;
  final String title;
  final String description;
  final GeoPointDto position;

  Map<String, dynamic> toJson() => _$CreatePostDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostDto {
  PostDto(this.id, this.image, this.title, this.description, this.position, this.user, this.comments, this.likes);

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String image;
  final String title;
  final String description;
  final GeoPointDto position;
  final PostAuthorDto user;
  final List<String> comments;
  final List<String> likes;

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PostResponseDto {
  PostResponseDto(this.post);

  factory PostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PostResponseDtoFromJson(json);

  final PostDto post;

  Map<String, dynamic> toJson() => _$PostResponseDtoToJson(this);
}

@JsonSerializable()
class PostAuthorDto {
  PostAuthorDto(this.id, this.username, this.image);

  factory PostAuthorDto.fromJson(Map<String, dynamic> json) =>
      _$PostAuthorDtoFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String image;

  Map<String, dynamic> toJson() => _$PostAuthorDtoToJson(this);
}
