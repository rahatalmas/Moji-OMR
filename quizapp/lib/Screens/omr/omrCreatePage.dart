import 'package:flutter/material.dart';
import 'package:quizapp/Screens/exam/dummyExamList.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/models/exammodel.dart';

class OmrCreatePage extends StatefulWidget {
  const OmrCreatePage({super.key});
  @override
  State<OmrCreatePage> createState() => _OmrCreatePage();
}

class _OmrCreatePage extends State<OmrCreatePage> {
  Exam? _selectedExam;

  void _onExamSelected(Exam exam) {
    setState(() {
      _selectedExam = exam;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Omr create page",
          style: TextStyle(color: appTextPrimary),
        ),
        centerTitle: true,
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: appTextPrimary),
        elevation: 3,
        shadowColor: Colors.grey,
        actions: [
          Icon(Icons.add_circle_outline),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: neutralWhite,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ExamFilterWidget(
              examList: examList,
              onExamSelected: (exam) {
                _onExamSelected(exam);
              },
            ),
            _selectedExam == null
                ? Center(
                    child: Text("no exam selected"),
                  )
                : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _selectedExam!.totalQuestions,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Question - ${index+1}'),
                         Row(

                         )
                       ],
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
