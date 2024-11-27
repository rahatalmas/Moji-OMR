import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/examProvider.dart';

import '../database/models/exammodel.dart';

class ExamFilterWidget extends StatefulWidget {
  final Function(Exam) onExamSelected;

  const ExamFilterWidget({
    super.key,
    required this.onExamSelected, required List<Exam> examList,
  });

  @override
  State<ExamFilterWidget> createState() => _ExamFilterWidgetState();
}

class _ExamFilterWidgetState extends State<ExamFilterWidget> {
  Exam? _selectedExam;

  void _showExamFilterModal(BuildContext context) async {
    final examProvider = Provider.of<ExamProvider>(context, listen: false);

    await examProvider.fetchExams('http://192.168.31.184:8080/api/exam/list');

    final examList = examProvider.exams;

    //the bottom sheet modal
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true, // Ensures that the bottom sheet takes up all available space
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Exam List",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: examList.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final exam = examList[index];
                      return ListTile(
                        title: Text(exam.name),
                        subtitle: Text(
                            "Date: ${exam.dateTime}, Location: ${exam.location}"),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          setState(() {
                            _selectedExam = exam;
                          });
                          widget.onExamSelected(exam);
                          Navigator.pop(context); // Close the modal
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showExamFilterModal(context),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: Colors.black12),
              color: neutralBG
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _selectedExam == null
                      ? "Select Exam"
                      : _selectedExam!.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,color: colorPrimary),
                ),
                SvgPicture.asset("assets/images/filter.svg",height: 20,color: colorPrimary,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
