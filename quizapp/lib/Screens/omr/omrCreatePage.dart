import 'package:flutter/material.dart';
import 'package:quizapp/Screens/exam/dummyExamList.dart';
import 'package:quizapp/Widgets/answerCircle.dart';
import 'package:quizapp/Widgets/answerCircles.dart';
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

  String? _selectedAnswer;
  List<String> _answerList = [];
  void _handleAnswerSelection(String label) {
    setState(() {
      _selectedAnswer = label;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label selected')),
    );
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
            SizedBox(height: 12,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(width:3,),
                    Text("Answer list")
                  ],
                ),
                Row(
                  children: [
                    Text("sort"),
                    SizedBox(width:3,),
                    Icon(Icons.sort),
                  ],
                )
              ],
            ),
            SizedBox(height: 12,),

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Question: ${index+1}'),
                            Text('correct option: ${"A"}')
                          ],
                        ),
                        AnswerCircles(),
                      ],
                    )                //circles for correct answer
                  );
                }
            ),

            SizedBox(height: 12,),
            _selectedExam == null
                ?
                Container()
                :
            InkWell(
              onTap: (){},
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Center(child: Text("Create",style: TextStyle(color: neutralWhite,fontSize: 22),)),
              ),
            ),
            SizedBox(height: 12,)
          ],
        ),
      ),
    );
  }
}
