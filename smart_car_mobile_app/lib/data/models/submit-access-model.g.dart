// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit-access-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitAccessModel _$SubmitAccessModelFromJson(Map<String, dynamic> json) =>
    SubmitAccessModel(
      token: json['token'] as String?,
      tcuId: json['tcuId'] as String?,
      notificationToken: json['notificationToken'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$SubmitAccessModelToJson(SubmitAccessModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tcuId': instance.tcuId,
      'deviceId': instance.deviceId,
      'notificationToken': instance.notificationToken,
    };
