class Exam {
  final String name;
  final String dateTime;
  final String location;
  final int duration;
  final int totalQuestions;
  final int numberOfCandidates;
  final int optionsPerQuestion;
  final List<String> questions;

  Exam({
    required this.name,
    required this.dateTime,
    required this.location,
    required this.duration,
    required this.totalQuestions,
    required this.numberOfCandidates,
    required this.optionsPerQuestion,
    this.questions = const [],
  });
}