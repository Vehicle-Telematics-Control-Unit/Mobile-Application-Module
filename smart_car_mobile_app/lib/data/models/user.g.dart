// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String?,
      password: json['password'] as String?,
      deviceId: json['deviceId'] as String?,
      email: json['email'] as String?,
    )..notificationToken = json['notificationToken'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'deviceId': instance.deviceId,
      'notificationToken': instance.notificationToken,
    };
