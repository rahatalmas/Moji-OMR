import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../database/models/exammodel.dart';
import '../handler/apis/login.dart';

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
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
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
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
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

  Future<bool> deleteExam(int id) async {
    print(exams.length);
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };
      final response = await http.delete(
        Uri.parse('$BASE_URL/api/exam/delete/$id'),
        headers: headers,
      );

      if (response.statusCode == 201) {
        print(_exams.length);
        _exams.removeWhere((exam) => exam.id == id);
        notifyListeners();
        print('Exam deleted successfully');
        return true;
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to delete exam: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
