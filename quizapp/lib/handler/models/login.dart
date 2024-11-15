import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  Login({
    this.message = "",
    this.username = "",
    this.accessToken = "",
    this.permission = 0,
  });

  @JsonKey(defaultValue: "")
  final String message;

  @JsonKey(defaultValue: "")
  final String username;

  @JsonKey(defaultValue: "")
  final String accessToken;

  @JsonKey(defaultValue: 0)
  final int permission;

  factory Login.fromJson(Map<String, dynamic>? json) {
    return _$LoginFromJson(Map<String, dynamic>.from(json ?? {}));
  }

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
