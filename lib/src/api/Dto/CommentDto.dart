import 'package:json_annotation/json_annotation.dart';

part 'CommentDto.g.dart';

@JsonSerializable()
class CreateCommentDto {
  CreateCommentDto(this.content);
  factory CreateCommentDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentDtoFromJson(json);

  final String content;

  Map<String, dynamic> toJson() => _$CreateCommentDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentResponseDto {
  CommentResponseDto(this.comment);

  factory CommentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseDtoFromJson(json);

  final CommentDto comment;

  Map<String, dynamic> toJson() => _$CommentResponseDtoToJson(this);
}

@JsonSerializable()
class CommentDto {
  CommentDto(this.id, this.content, this.user, this.post);

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  final String id;
  final String content;
  final String user;
  final String post;

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}
