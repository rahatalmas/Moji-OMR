import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/handler/apis/login.dart';

import '../database/models/exammodel.dart';
import '../handler/apis/examApiUtil.dart';

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
}
