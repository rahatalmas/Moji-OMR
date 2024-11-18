import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/handler/models/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHandler {
  // function to return login information.
  Future<String?> loginApi() async {
    String apiLink = "http://192.168.31.184:8080/api/user/login/";
    try {
      var url = Uri.parse(apiLink);
      var response = await http.post(
        headers: {
          "Content-Type": "application/json",
        },
        url,
        body: jsonEncode({"username": "konan", "password": "akatsuki"}),
      );
      print(response.body);
      var res = Login.fromJson(jsonDecode(response.body));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', res.accesstoken);

      debugPrint(res.accesstoken.toString());
      debugPrint(res.message);
      debugPrint(res.permission.toString());
      debugPrint(res.username);
      return res.accesstoken;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
