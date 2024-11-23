import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';

class ExamCard extends StatelessWidget {
  final int examId;
  final String examName;
  final DateTime examDate;
  final String examLocation;
  final int examDuration;
  final int questionCount;
  final int candidateCount;// Callback function for InkWell tap

  const ExamCard({
    Key? key,
    required this.examId,
    required this.examName,
    required this.examDate,
    required this.examLocation,
    required this.examDuration,
    required this.questionCount,
    required this.candidateCount, // Optional onTap callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
      decoration: BoxDecoration(
        color: neutralWhite,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 1,
            spreadRadius: 1, // Spread of shadow
            offset: Offset.zero, // Shadow is even on all sides
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            print("hello");
          },// Trigger action on tap
          borderRadius: BorderRadius.circular(12.0), // Match container's border radius
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(examName, style: const TextStyle(fontSize:17,fontWeight: FontWeight.bold,color: colorPrimary)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16,color: colorPrimary,),
                    const SizedBox(width: 8),
                    Text("Date: ${_formatDate(examDate)}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16,color: colorPrimary,),
                    const SizedBox(width: 8),
                    Text("Location: $examLocation"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.timer, size: 16,color: colorPrimary,),
                    const SizedBox(width: 8),
                    Text("Duration: $examDuration hours"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.help_outline, size: 16,color: colorPrimary,),
                    const SizedBox(width: 8),
                    Text("Questions: $questionCount"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, size: 16,color: colorPrimary,),
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

  // Helper function to format the date
  static String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}
