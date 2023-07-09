import 'package:json_annotation/json_annotation.dart';

part 'get-tcu-model.g.dart';

@JsonSerializable()
class GetTcuModel {
  @JsonKey(name: "id")
  int id;
  GetTcuModel({
    required this.id,
  });
  factory GetTcuModel.fromJson(Map<String, dynamic> json) =>
      _$GetTcuModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetTcuModelToJson(this);
}
