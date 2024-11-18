import 'package:quizapp/models/exammodel.dart';

final List<Exam> examList = [
  Exam(
    name: "Math Exam",
    dateTime: "2024-11-20 10:00 AM",
    location: "Room 101",
    duration: 60,
    totalQuestions: 20,
    numberOfCandidates: 30,
    optionsPerQuestion: 4,
  ),
  Exam(
    name: "Science Exam",
    dateTime: "2024-11-21 12:00 PM",
    location: "Room 202",
    duration: 90,
    totalQuestions: 25,
    numberOfCandidates: 25,
    optionsPerQuestion: 4,
  ),
  // Add more exams as needed
];
