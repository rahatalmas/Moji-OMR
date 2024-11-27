import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizapp/handler/api_handler.dart';
import 'package:quizapp/handler/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth implements BaseAuthHandler {
  String? _hasAccessToken;

  String? get hasAccessToken => _hasAccessToken;

  Login _login = Login.fromJson({});

  @override
  String? getUserToken() {
    var tokenAccessToken = getAccessToken();
    // return tokenAccessToken;
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<Login?> login(String user, String password) async {
    print("$user $password");

    String apiLink = "http://192.168.31.184:8080/api/user/login/";
    try {
      var url = Uri.parse(apiLink);
      var response = await http.post(
        headers: {
          "Content-Type": "application/json",
        },
        url,
        body: jsonEncode({"username": user, "password": password}),
      );
      Login? res = Login.fromJson(jsonDecode(response.body));
      _login = res;
      return res;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Future<void> refreshUserToken() {
    // TODO: implement refreshUserToken
    throw UnimplementedError();
  }

  @override
  Future<void> setAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_login.accesstoken.isNotEmpty) {
      final currentTime = DateTime.now().microsecondsSinceEpoch;
      final expireTime = currentTime + const Duration(days: 30).inMilliseconds;
      await prefs.setString('access_token', _login.accesstoken);
      await prefs.setInt('token_expire', expireTime);
    }
  }

  @override
  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    final expireTime = prefs.getInt("token_expire");
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (token != null && expireTime != null && currentTime < expireTime) {
      _hasAccessToken = token;
    }
    // todo: In else block we have to add refresh token in future.
  }
}
