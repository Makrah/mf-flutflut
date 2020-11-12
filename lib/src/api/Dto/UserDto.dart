import 'package:json_annotation/json_annotation.dart';

part 'UserDto.g.dart';

@JsonSerializable()
class UserDto {
  final String id;
  final String username;
  final String image;

  UserDto(this.id, this.username, this.image);

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserResponseDto {
  final UserDto user;

  UserResponseDto(this.user);

  factory UserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDtoFromJson(json);
}

@JsonSerializable()
class UpdateUserDto {
  final String username;
  final String image;

  UpdateUserDto(this.username, this.image);

  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);
}
