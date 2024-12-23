import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/constant.dart';
import 'package:quizapp/handler/apis/login.dart';
import '../../database/models/getresult.dart';

class ResultApi with ChangeNotifier {
  ResultApi._privateConstructor();

  static final ResultApi _instance = ResultApi._privateConstructor();

  factory ResultApi() {
    return _instance;
  }

  bool _isLoading = false;
  String _message = '';

  bool get isLoading => _isLoading;
  String get message => _message;

  // Fetch results from the server
  Future<List<GetResult>> fetchResults() async {
    _isLoading = true;
    _message = '';
    notifyListeners();
    List<GetResult> results = [];
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };
      final response = await http.get(
        Uri.parse('$BASE_URL/api/result/allresult'),
        headers: headers,
      );

      print("status code"+response.statusCode.toString());
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        results = jsonData.map((data) => GetResult.fromJson(data)).toList();
      } else {
        _message = 'Error ${response.statusCode}';
      }
    } catch (err) {
      print(err);
      _message = 'Failed to fetch results';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return results;
  }

  //method to reset the message and loading state
  void reset() {
    _message = '';
    _isLoading = false;
    notifyListeners();
  }
}
