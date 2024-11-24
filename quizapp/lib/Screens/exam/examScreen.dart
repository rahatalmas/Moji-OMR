import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
        actions: [
          Icon(Icons.add),
          SizedBox(width: 16,),

        ],
      ),
      backgroundColor: neutralWhite,
      body: Center(
        child: examProvider.isLoading
            ? CircularProgressIndicator()
            : examProvider.message.isNotEmpty
            ? Text(examProvider.message)
            : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                   Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12),
                     margin: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: neutralBG,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.2),
                           blurRadius: 1,
                           spreadRadius: 1, // Spread of shadow
                           offset: Offset.zero, // Shadow is even on all sides
                         ),
                       ],
                     ),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.newspaper,color: colorPrimary,),
                            SizedBox(width: 3,),
                            Text("All Time",style: TextStyle(color: colorPrimary),)
                          ],
                        ),
                        SvgPicture.asset("assets/images/filter.svg",height: 20,color: colorPrimary,)
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  ListView.builder(
                    shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                ],
              ),
            ),
      ),
    );
  }
}
