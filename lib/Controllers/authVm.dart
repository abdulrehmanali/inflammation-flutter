import 'package:anti_inflammatory_app/Utils/toast.dart';
import 'package:anti_inflammatory_app/storage/userstorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Model/loginusermodel.dart';
import '../constant/api.dart';

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}

class AuthVm with ChangeNotifier {
  LoginUserModel? _user = LoginUserModel();
  LoginUserModel? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoadingF(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<LoginUserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(UserStorage.uidKey).toString();
    final name = prefs.getString(UserStorage.nameKey).toString();
    final email = prefs.getString(UserStorage.emailKey).toString();
    final token = prefs.getString(UserStorage.tokenKey).toString();
    _user = LoginUserModel.fromJson(
        {"_id": id, "name": name, "email": email, "token": token});
    notifyListeners();
    return _user;
  }

  Future login(context, {String email = "", String password = ""}) async {
    isLoadingF = true;
    try {
      final response = await http.post(Uri.parse(ApiUrls.login),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}));
      final responseData = json.decode(response.body);
      snackBarColorF("${responseData['message']}", context);
      if (responseData['success'] == false) {
        return;
      }

      final resultsData = responseData['results']['data'];
      _user = LoginUserModel.fromJson(resultsData);
      await UserStorage.setUserF(
          uid: _user!.id.toString(),
          name: _user!.name.toString(),
          email: _user!.email.toString(),
          token: responseData['results']['token'].toString());
      notifyListeners();
      Get.offNamed('/home');
    } catch (e, st) {
      snackBarColorF("$e", context);
      debugPrint("error: $e , st:$st");
    } finally {
      isLoadingF = false;
    }
  }

  Future signup(context,
      {String name = "",
      String email = "",
      String password = "",
      String code = ""}) async {
    try {
      isLoadingF = true;
      final response = await http.post(Uri.parse(ApiUrls.signup),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': name,
            'email': email,
            'password': password,
            'code': code
          }));
      final resp = json.decode(response.body);
      snackBarColorF("${resp['message']}", context);
      if (resp['success'] == false) {
        return;
      }
      Get.offNamed('/login');

// {
//     "success": false,
//     "message": "Password must contain at least one lower case letter"
// }
// {
//     "success": false,
//     "message": "User already exists"
// }
// {
//     "success": false,
//     "message": "Invalid referral code"
// }

// {
//     "success": true,
//     "message": "User created successfully",
//     "user": {
//         "name": "user1",
//         "email": "user1@gmail.com",
//         "password": "$2b$12$RsGnFRz6Qsx78sDMsGo1Ue3uLnNt9gdasDazwHw6vlPZwXhbKPTaC",
//         "private": false,
//         "level": 0,
//         "referrel": "",
//         "_id": "6718fccd842a40f920fe0530",
//         "__v": 0
//     }
// }
    } catch (error) {
      print(error);
      snackBarColorF(error, context);
    } finally {
      isLoadingF = false;
      notifyListeners();
    }
  }

  //////////////
  Future updateProfile(BuildContext context,
      {String name = "", String email = ""}) async {
    try {
      isLoadingF = true;
      final resp = await http.put(Uri.parse(ApiUrls.updateUser),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${_user?.token}'
          },
          body: json.encode({'name': name, 'email': email}));
      var resp2 = json.decode(resp.body);
      snackBarColorF("${resp2['message']}", context);
      if (resp2['success'] == false) {
        return;
      }
      _user?.name = name.toString();
      _user?.email = email.toString();

      await UserStorage.setUserF(
          name: name.toString(), email: email.toString());
    } catch (e, st) {
      debugPrint("error: $e , st:$st");
      snackBarColorF(e, context);
    } finally {
      isLoadingF = false;
      notifyListeners();
    }
  }
}
