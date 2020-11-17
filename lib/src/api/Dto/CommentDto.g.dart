// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommentDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentDto _$CreateCommentDtoFromJson(Map<String, dynamic> json) {
  return CreateCommentDto(
    json['content'] as String,
  );
}

Map<String, dynamic> _$CreateCommentDtoToJson(CreateCommentDto instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

CommentResponseDto _$CommentResponseDtoFromJson(Map<String, dynamic> json) {
  return CommentResponseDto(
    json['comment'] == null
        ? null
        : CommentDto.fromJson(json['comment'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentResponseDtoToJson(CommentResponseDto instance) =>
    <String, dynamic>{
      'comment': instance.comment?.toJson(),
    };

CommentDto _$CommentDtoFromJson(Map<String, dynamic> json) {
  return CommentDto(
    json['_id'] as String,
    json['content'] as String,
    json['user'] == null
        ? null
        : CommentAuthorDto.fromJson(json['user'] as Map<String, dynamic>),
    json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$CommentDtoToJson(CommentDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'user': instance.user,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

CommentAuthorDto _$CommentAuthorDtoFromJson(Map<String, dynamic> json) {
  return CommentAuthorDto(
    json['_id'] as String,
    json['username'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$CommentAuthorDtoToJson(CommentAuthorDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'image': instance.image,
    };
