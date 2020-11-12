import 'package:json_annotation/json_annotation.dart';
import 'package:testApp/src/api/Dto/UserDto.dart';

part 'LoginDto.g.dart';

@JsonSerializable()
class LoginDto {
  final String username;
  final String password;

  LoginDto(this.username, this.password);

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginResponseDto {
  final UserDto user;
  final String token;

  LoginResponseDto(this.user, this.token);

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}
