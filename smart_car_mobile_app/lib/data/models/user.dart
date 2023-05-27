// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "deviceId")
  String? deviceId;
  @JsonKey(name: "notificationToken")
  String? notificationToken;

  User({this.username, this.password,this.deviceId,this.email,this.notificationToken});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
