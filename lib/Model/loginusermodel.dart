import 'package:anti_inflammatory_app/helpers/nullables.dart';

class LoginUserModel {
  String level;
  String referral;
  String id;
  String name;
  String email;
  String password;
  String v;
  bool isPrivate;
  String token;

  LoginUserModel({
    this.level = "0",
    this.referral = "",
    this.id = "0",
    this.name = "",
    this.email = "",
    this.password = "",
    this.v = "0",
    this.isPrivate = true,
    this.token = "",
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      level: json['level'].toString().toNullString(),
      referral: json['referral'].toString().toNullString(),
      id: json['_id'].toString().toNullString(),
      name: json['name'].toString().toNullString(),
      email: json['email'].toString().toNullString(),
      password: json['password'].toString().toNullString(),
      v: json['__v'].toString().toNullString(),
      token: json['token'].toString().toNullString(),
      isPrivate: json['private'] ?? false,
    );
  }
}
