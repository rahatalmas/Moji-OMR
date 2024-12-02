import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../database/models/exammodel.dart';

class ExamApiUtil {
  final String accessToken;

  ExamApiUtil(this.accessToken);

  Map<String, String> get _headers => {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };

  // Fetch all exams
  Future<List<Exam>> fetchExams(String url) async {
    try {
      final response = await http.get(Uri.parse(url), headers: _headers);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => Exam.fromJson(data)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch exams: $e');
    }
  }

  // Add a new exam
  Future<bool> addExam(String url, Exam newExam) async {
    try {
      final body = jsonEncode(newExam.toJson());
      final response = await http.post(
        Uri.parse(url),
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add exam: $e');
    }
  }

  // Fetch exam by ID
  Future<Exam> fetchById(String url, String id) async {
    try {
      final response = await http.get(
        Uri.parse('$url/$id'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        return Exam.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch exam by ID: $e');
    }
  }

  // Delete an exam
  Future<bool> deleteExam(String url, String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/$id'),
        headers: _headers,
      );

      if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to delete exam: $e');
    }
  }

  // Update an exam
  Future<bool> updateExam(String url, String id, Exam updatedExam) async {
    try {
      final body = jsonEncode(updatedExam.toJson());
      final response = await http.put(
        Uri.parse('$url/$id'),
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to update exam: $e');
    }
  }
}
