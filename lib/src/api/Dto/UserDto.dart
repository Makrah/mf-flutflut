import 'package:json_annotation/json_annotation.dart';

part 'UserDto.g.dart';

@JsonSerializable()
class UserDto {
  UserDto(this.id, this.username, this.image);
  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  final String id;
  final String username;
  final String image;


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
