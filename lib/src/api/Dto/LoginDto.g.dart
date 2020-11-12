// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) {
  return LoginDto(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) {
  return LoginResponseDto(
    json['user'] == null
        ? null
        : UserDto.fromJson(json['user'] as Map<String, dynamic>),
    json['token'] as String,
  );
}

Map<String, dynamic> _$LoginResponseDtoToJson(LoginResponseDto instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'token': instance.token,
    };
