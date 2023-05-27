import 'package:json_annotation/json_annotation.dart';

part 'verify-user-command.g.dart';

@JsonSerializable()
class VerifyUserCommand {
  @JsonKey(name: "userEmail")
  String? userEmail;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "deviceId")
  String? deviceId;
  @JsonKey(name: "notificationToken")
  String? notificationToken;

  VerifyUserCommand({this.userEmail, this.token, this.deviceId,this.notificationToken});
  factory VerifyUserCommand.fromJson(Map<String, dynamic> json) =>
      _$VerifyUserCommandFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyUserCommandToJson(this);
}
