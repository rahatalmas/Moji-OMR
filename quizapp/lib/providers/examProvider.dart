import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/models/exammodel.dart';

class ExamProvider with ChangeNotifier {
  List<Exam> _exams = [];
  bool _isLoading = false;
  String _message = '';

  // Getters
  List<Exam> get exams => _exams;
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<void> fetchExams(String url) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      // Add the access token to the headers
      final headers = {
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFsbWFzIiwia2V5IjoiYWRtaW5fa2V5IiwiaWF0IjoxNzMyMjk1MTMyLCJleHAiOjE3MzIyOTU3MzJ9.gdLymrn9SAgJopUbwg5k3gcS1dGRZ0HbS0LvLJgrlvky1ddAgEByBH45FArF7mDZ_YxQ8f1ti7Elvdk-eYKoqA',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        _exams = jsonData.map((data) => Exam.fromJson(data)).toList();
      } else {
        _message = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Failed to parse Exam: $e');
      _message = 'Failed to fetch exams: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addExam(String url, Exam newExam) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final headers = {
        'Authorization': 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFsbWFzIiwia2V5IjoiYWRtaW5fa2V5IiwiaWF0IjoxNzMyMjk1MzI5LCJleHAiOjE3MzIyOTU5Mjl9.u0Y0L6lkGvk-86XEyulv5YykTC5Ig1BD73W54G01cEKQKqpFlE3lWdKT7ALQ-tA-HQkJSMx9pcmWOOE4HkuSTg',
        'Content-Type': 'application/json',
      };

      // Use `toJson()` from the model (excludes `id` for POST requests)
      final body = jsonEncode(newExam.toJson());

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        print('Exam added successfully');
        return true;
      } else {
        _message = 'Error: ${response.statusCode}, ${response.body}';
        return false;
      }
    } catch (e) {
      _message = 'Failed to add exam: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
