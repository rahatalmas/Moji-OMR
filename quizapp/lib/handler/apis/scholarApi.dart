import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/scholar.dart';
import 'package:quizapp/handler/apis/login.dart';


class ScholarApi with ChangeNotifier {
  ScholarApi._privateConstructor();

  static final ScholarApi _instance = ScholarApi._privateConstructor();

  factory ScholarApi(){
    return _instance;
  }

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;

  String get message => _message;

  Future<List<Scholar>> fetchScholars() async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    List<Scholar> scholars = [];

    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
          Uri.parse('$BASE_URL/api/scholar/list'), headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        scholars = jsonData.map((data) => Scholar.fromJson(data)).toList();
        print(scholars.length);
      } else {
        _message = 'Error ${response.statusCode}';
      }
    } catch (err) {
      print('Failed to fetch scholars: $err');
      _message = 'Failed to fetch exams: $err';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return scholars;
  }
}

