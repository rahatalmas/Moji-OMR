import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Widgets/examCard.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/examProvider.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExamProvider>(context, listen: false)
          .fetchExams('http://192.168.31.184:8080/api/exam/list');
    });
  }

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Exams'),
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
      ),
      body: Center(
        child: examProvider.isLoading
            ? CircularProgressIndicator()
            : examProvider.message.isNotEmpty
            ? Text(examProvider.message)
            : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                        itemCount: examProvider.exams.length,
                        itemBuilder: (context, index) {
              final exam = examProvider.exams[index];
              return ExamCard(
                  examId: exam.id,
                  examName: exam.name,
                  examDate: DateTime.parse(exam.dateTime),
                  examLocation: exam.location,
                  examDuration: exam.duration,
                  questionCount: exam.totalQuestions,
                  candidateCount: exam.numberOfCandidates
              );
                        },
                      ),
            ),
      ),
    );
  }
}
