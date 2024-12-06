import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/handler/apis/login.dart';

import '../constant.dart';
import '../database/models/exammodel.dart';
import '../handler/apis/examApiUtil.dart';
import '../handler/apis/login.dart';

class ExamProvider with ChangeNotifier {
  List<Exam> _exams = [];
  bool _isLoading = false;
  bool _dataUpdated = false;
  String _message = '';

  // Getters
  List<Exam> get exams => _exams;

  bool get isLoading => _isLoading;

  bool get dataUpdated => _dataUpdated;

  String get message => _message;

  void reset() {
    _dataUpdated = false;
    notifyListeners();
  }

  Future<void> getAllExams(String url) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      _exams = await ExamApiUtil(Auth().loginData!.accesstoken).fetchExams(url);
      _isLoading = false;
      _dataUpdated = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> addExam(String url, Exam newExam) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      bool result = await ExamApiUtil(Auth().loginData!.accesstoken)
          .addExam(url, newExam);
      _dataUpdated = result;
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _message = 'Failed to add exam: $e';
      return false;
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
