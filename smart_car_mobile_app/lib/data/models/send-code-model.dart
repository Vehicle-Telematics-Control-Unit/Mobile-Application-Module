
import 'package:json_annotation/json_annotation.dart';
part 'send-code-model.g.dart';

@JsonSerializable()
class SendCodeModel {
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "deviceId")
  String? deviceId;
  SendCodeModel({this.username, this.deviceId});

factory SendCodeModel.fromJson(Map<String, dynamic> json) =>
    _$SendCodeModelFromJson(json);

Map<String, dynamic> toJson() => _$SendCodeModelToJson(this);

  

}