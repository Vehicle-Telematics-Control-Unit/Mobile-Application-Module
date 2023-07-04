import 'package:json_annotation/json_annotation.dart';
part 'change-password-model.g.dart';

@JsonSerializable()
class ChangePasswordModel {
  @JsonKey(name: "newPassword")
  String? newPassword;
  @JsonKey(name: "password")
  String? password;
  ChangePasswordModel({this.password, this.newPassword});
  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordModelToJson(this);
}
