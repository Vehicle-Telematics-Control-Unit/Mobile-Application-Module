// ignore: file_names

import 'package:json_annotation/json_annotation.dart';
part 'login-response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "expiration")
  String? expiration;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "email")
  String? email;
  
 

  LoginResponse({this.token, this.expiration, this.username, this.email});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
