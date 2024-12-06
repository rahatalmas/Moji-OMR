import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../../database/models/exammodel.dart';
import 'login.dart';

class ExamApiUtil with ChangeNotifier {
  // Private constructor for singleton pattern
  ExamApiUtil._privateConstructor();

  // Static instance of ExamApiUtil
  static final ExamApiUtil _instance = ExamApiUtil._privateConstructor();

  // Factory constructor to return the same instance
  factory ExamApiUtil() {
    return _instance;
  }

  bool _isLoading = false;
  String _message = '';

  // Getters
  bool get isLoading => _isLoading;
  String get message => _message;

  Future<List<Exam>> fetchExams() async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    List<Exam> exams = [];

    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse('$BASE_URL/api/exam/list'), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        exams = jsonData.map((data) => Exam.fromJson(data)).toList();
      } else {
        _message = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      print('Failed to fetch exams: $e');
      _message = 'Failed to fetch exams: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return exams;
  }

  Future<bool> addExam(Exam newExam) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(newExam.toJson());

      final response = await http.post(
        Uri.parse('$BASE_URL/api/exam/add'),
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
    try {
      final headers = {
        'Authorization': 'Bearer ${Auth().loginData!.accesstoken}',
        'Content-Type': 'application/json',
      };

      final response = await http.delete(
        Uri.parse('$BASE_URL/api/exam/delete/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
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
