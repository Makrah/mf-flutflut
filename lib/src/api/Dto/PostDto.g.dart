// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostDto _$CreatePostDtoFromJson(Map<String, dynamic> json) {
  return CreatePostDto(
    json['image'] as String,
    json['title'] as String,
    json['description'] as String,
    json['position'] == null
        ? null
        : GeoPointDto.fromJson(json['position'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreatePostDtoToJson(CreatePostDto instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'position': instance.position?.toJson(),
    };

PostDto _$PostDtoFromJson(Map<String, dynamic> json) {
  return PostDto(
    json['image'] as String,
    json['title'] as String,
    json['description'] as String,
    json['position'] == null
        ? null
        : GeoPointDto.fromJson(json['position'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostDtoToJson(PostDto instance) => <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'position': instance.position?.toJson(),
    };

PostResponseDto _$PostResponseDtoFromJson(Map<String, dynamic> json) {
  return PostResponseDto(
    json['post'] == null
        ? null
        : PostDto.fromJson(json['post'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostResponseDtoToJson(PostResponseDto instance) =>
    <String, dynamic>{
      'post': instance.post?.toJson(),
    };

PostAuthorDto _$PostAuthorDtoFromJson(Map<String, dynamic> json) {
  return PostAuthorDto(
    json['id'] as String,
    json['username'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$PostAuthorDtoToJson(PostAuthorDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'image': instance.image,
    };
