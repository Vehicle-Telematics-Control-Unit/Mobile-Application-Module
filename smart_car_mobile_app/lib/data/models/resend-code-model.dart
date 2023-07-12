import 'package:json_annotation/json_annotation.dart';

part 'resend-code-model.g.dart';

@JsonSerializable()
class ResendCodeModel {
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "deviceId")
  String? deviceId;
  ResendCodeModel({this.username, this.deviceId});
  factory ResendCodeModel.fromJson(Map<String, dynamic> json) =>
      _$ResendCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResendCodeModelToJson(this);
}