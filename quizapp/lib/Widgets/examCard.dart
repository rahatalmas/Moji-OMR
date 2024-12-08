import 'package:flutter/material.dart';
import 'package:quizapp/Screens/exam/examUpdateScreen.dart';
import 'package:quizapp/constant.dart';

class ExamCard extends StatelessWidget {
  final int examId;
  final String examName;
  final DateTime examDate;
  final String examLocation;
  final int examDuration;
  final int questionCount;
  final int candidateCount;
  final VoidCallback onDelete; // Callback for delete action

  const ExamCard({
    Key? key,
    required this.examId,
    required this.examName,
    required this.examDate,
    required this.examLocation,
    required this.examDuration,
    required this.questionCount,
    required this.candidateCount,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: neutralWhite,
      elevation: 4,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: (){
            print('hello');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    border: BorderDirectional(bottom: BorderSide(color: Colors.black12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Created on: ${_formatDate(examDate)}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>UpdateExamScreen(
                                        examId: examId,
                                        examName: examName,
                                        examDateTime: examDate,
                                        examLocation: examLocation,
                                        examDuration: examDuration,
                                        questionCount: questionCount,
                                        candidateCount: candidateCount
                                    )
                                ));
                              },
                              child: Icon(Icons.edit_note,color: colorPrimary,)
                          ),
                          SizedBox(width: 5,),
                          InkWell(
                            onTap: onDelete,
                            child: Icon(Icons.delete, color: Colors.red[900]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  examName,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: colorPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Date: ${_formatDate(examDate)}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Location: $examLocation"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Duration: $examDuration hours"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.help_outline, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Questions: $questionCount"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, size: 16, color: colorPrimary),
                    const SizedBox(width: 8),
                    Text("Candidates: $candidateCount"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}
