// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) {
  return UserDto(
    json['id'] as String,
    json['username'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'image': instance.image,
    };

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) {
  return UserResponseDto(
    json['user'] == null
        ? null
        : UserDto.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResponseDtoToJson(UserResponseDto instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };

UpdateUserDto _$UpdateUserDtoFromJson(Map<String, dynamic> json) {
  return UpdateUserDto(
    json['username'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$UpdateUserDtoToJson(UpdateUserDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'image': instance.image,
    };
