// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify-user-command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyUserCommand _$VerifyUserCommandFromJson(Map<String, dynamic> json) =>
    VerifyUserCommand(
      userEmail: json['userEmail'] as String?,
      token: json['token'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$VerifyUserCommandToJson(VerifyUserCommand instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'token': instance.token,
      'deviceId': instance.deviceId,
    };
