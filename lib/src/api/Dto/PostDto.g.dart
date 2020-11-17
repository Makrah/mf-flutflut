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
    json['_id'] as String,
    json['image'] as String,
    json['title'] as String,
    json['description'] as String,
    json['position'] == null
        ? null
        : GeoPointDto.fromJson(json['position'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : PostAuthorDto.fromJson(json['user'] as Map<String, dynamic>),
    (json['comments'] as List)?.map((e) => e as String)?.toList(),
    (json['likes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PostDtoToJson(PostDto instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'position': instance.position?.toJson(),
      'user': instance.user?.toJson(),
      'comments': instance.comments,
      'likes': instance.likes,
    };

PostDetailDto _$PostDetailDtoFromJson(Map<String, dynamic> json) {
  return PostDetailDto(
    json['_id'] as String,
    json['image'] as String,
    json['title'] as String,
    json['description'] as String,
    json['position'] == null
        ? null
        : GeoPointDto.fromJson(json['position'] as Map<String, dynamic>),
    json['user'] == null
        ? null
        : PostAuthorDto.fromJson(json['user'] as Map<String, dynamic>),
    (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : CommentDto.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['likes'] as List)?.map((e) => e as String)?.toList(),
    json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$PostDetailDtoToJson(PostDetailDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'position': instance.position?.toJson(),
      'user': instance.user?.toJson(),
      'comments': instance.comments?.map((e) => e?.toJson())?.toList(),
      'likes': instance.likes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

PostResponseDto _$PostResponseDtoFromJson(Map<String, dynamic> json) {
  return PostResponseDto(
    json['post'] == null
        ? null
        : PostDetailDto.fromJson(json['post'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostResponseDtoToJson(PostResponseDto instance) =>
    <String, dynamic>{
      'post': instance.post?.toJson(),
    };

PostAuthorDto _$PostAuthorDtoFromJson(Map<String, dynamic> json) {
  return PostAuthorDto(
    json['_id'] as String,
    json['username'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$PostAuthorDtoToJson(PostAuthorDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'image': instance.image,
    };
