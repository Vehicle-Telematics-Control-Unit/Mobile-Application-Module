import 'package:json_annotation/json_annotation.dart';
part 'submit-access-model.g.dart';

@JsonSerializable()
class SubmitAccessModel {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "tcuId")
  String? tcuId;
  @JsonKey(name: "deviceId")
  String? deviceId;
  @JsonKey(name: "notificationToken")
  String? notificationToken;

  SubmitAccessModel({this.token, this.tcuId, this.notificationToken,this.deviceId});
  factory SubmitAccessModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitAccessModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitAccessModelToJson(this);
}
