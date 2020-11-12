import 'package:json_annotation/json_annotation.dart';

part 'CommentDto.g.dart';

@JsonSerializable()
class CreateCommentDto {
  final String content;

  CreateCommentDto(this.content);

  Map<String, dynamic> toJson() => _$CreateCommentDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommentResponseDto {
  final CommentDto comment;

  CommentResponseDto(this.comment);

  factory CommentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CommentResponseDtoToJson(this);
}

@JsonSerializable()
class CommentDto {
  final String id;
  final String content;
  final String user;
  final String post;

  CommentDto(this.id, this.content, this.user, this.post);

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}
