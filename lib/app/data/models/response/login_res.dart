import 'dart:convert';

LoginResponse loginResponseFromJson(Map<String, dynamic> str) =>
    LoginResponse.fromJson(str);

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final String id;
  final String username;
  final String token;

  LoginResponse({
    required this.id,
    required this.username,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        username: json["username"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "token": token,
      };
}
