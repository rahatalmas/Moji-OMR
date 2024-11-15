import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/handler/models/login.dart';

class ApiHandler {
  void loginApi() async {
    String apiLink = "http://192.168.31.184:8080/api/user/login/";
    var url = Uri.parse(apiLink);
    var response = await http.post(
      headers: {
        "Content-Type": "application/json",
      },
      url,
      body: jsonEncode({"username": "konan", "password": "akatsuki"}),
    );

    var res = Login.fromJson(jsonDecode(response.body));
    debugPrint(res.accessToken.toString());
    debugPrint(res.message);
    debugPrint(res.permission.toString());
    debugPrint(res.username);
  }
}
