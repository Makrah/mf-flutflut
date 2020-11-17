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
  CommentDto(this.id, this.content, this.user, this.createdAt);

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String content;
  final CommentAuthorDto user;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}

@JsonSerializable()
class CommentAuthorDto {
  CommentAuthorDto(this.id, this.username, this.image);

  factory CommentAuthorDto.fromJson(Map<String, dynamic> json) =>
      _$CommentAuthorDtoFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String image;

  Map<String, dynamic> toJson() => _$CommentAuthorDtoToJson(this);
}
