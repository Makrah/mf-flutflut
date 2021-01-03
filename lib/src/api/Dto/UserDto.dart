import 'package:json_annotation/json_annotation.dart';
import 'package:mappin/src/api/Dto/PostDto.dart';

part 'UserDto.g.dart';

@JsonSerializable()
class UserDto {
  UserDto(this.id, this.username, this.image, this.posts);
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String image;
  final List<PostDto> posts;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserResponseDto {
  UserResponseDto(this.user);
  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);

  final UserDto user;

  Map<String, dynamic> toJson() => _$UserResponseDtoToJson(this);
}

@JsonSerializable()
class UpdateUserDto {
  UpdateUserDto(this.username, this.image);
  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  final String username;
  final String image;

  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);
}

@JsonSerializable()
class UpdateUserImageDto {
  UpdateUserImageDto(this.image);
  factory UpdateUserImageDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserImageDtoFromJson(json);

  final String image;

  Map<String, dynamic> toJson() => _$UpdateUserImageDtoToJson(this);
}
