import 'package:json_annotation/json_annotation.dart';

part 'feature-model.g.dart';

@JsonSerializable()
class Feature {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "state")
  int state;

  Feature({
    required this.id,
    required this.name,
    required this.description,
    required this.state,
  });
  factory Feature.fromJson(Map<String, dynamic> json) =>
      _$FeatureFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}
