import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      appBar: AppBar(title: Text('Exams')),
      body: Center(
        child: examProvider.isLoading
            ? CircularProgressIndicator()
            : examProvider.message.isNotEmpty
            ? Text(examProvider.message)
            : ListView.builder(
          itemCount: examProvider.exams.length,
          itemBuilder: (context, index) {
            final exam = examProvider.exams[index];
            return ListTile(
              title: Text(exam.name),
              subtitle: Text('Location: ${exam.location}'),
              trailing: Text('Duration: ${exam.duration} hrs'),
            );
          },
        ),
      ),
    );
  }
}
