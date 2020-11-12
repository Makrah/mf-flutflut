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
    json['id'] as String,
    json['content'] as String,
    json['user'] as String,
    json['post'] as String,
  );
}

Map<String, dynamic> _$CommentDtoToJson(CommentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'user': instance.user,
      'post': instance.post,
    };
