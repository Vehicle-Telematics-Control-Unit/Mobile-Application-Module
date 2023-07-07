import 'package:json_annotation/json_annotation.dart';

part 'get-feature-model.g.dart';

@JsonSerializable()
class GetFeatureModel {
  @JsonKey(name: "featureId")
  int? featureId;

  GetFeatureModel({this.featureId});
  factory GetFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$GetFeatureModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetFeatureModelToJson(this);
}
