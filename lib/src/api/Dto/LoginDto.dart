import 'package:json_annotation/json_annotation.dart';
import 'package:mappin/src/api/Dto/UserDto.dart';

part 'LoginDto.g.dart';

@JsonSerializable()
class LoginDto {
  LoginDto(this.username, this.password);

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginResponseDto {
  LoginResponseDto(this.user, this.token);

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  final UserDto user;
  final String token;

  Map<String, dynamic> toJson() => _$LoginResponseDtoToJson(this);
}
