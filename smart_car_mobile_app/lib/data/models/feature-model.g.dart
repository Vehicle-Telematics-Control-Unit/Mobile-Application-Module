// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feature _$FeatureFromJson(Map<String, dynamic> json) => Feature(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      state: json['state'] as int,
    );

Map<String, dynamic> _$FeatureToJson(Feature instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'state': instance.state,
    };
