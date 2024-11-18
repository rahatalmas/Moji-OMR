import 'package:flutter/material.dart';
import 'package:quizapp/models/exammodel.dart';


class ExamFilterWidget extends StatefulWidget {
  final List<Exam> examList;
  final Function(Exam) onExamSelected;

  const ExamFilterWidget({
    Key? key,
    required this.examList,
    required this.onExamSelected,
  }) : super(key: key);

  @override
  State<ExamFilterWidget> createState() => _ExamFilterWidgetState();
}

class _ExamFilterWidgetState extends State<ExamFilterWidget> {
  Exam? _selectedExam;

  void _showExamFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,  // This ensures that the bottom sheet takes up all available space
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height-200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Exam List",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.examList.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final exam = widget.examList[index];
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
                          Navigator.pop(context);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedExam == null ? "Select Exam" : _selectedExam!.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () => _showExamFilterModal(context),
              child: const Icon(Icons.filter_list, color: Colors.black),
            ),
          ],
        ),
        if (_selectedExam != null) ...[
          const SizedBox(height: 10),
          Text("Details for: ${_selectedExam!.name}"),
          Text("Date & Time: ${_selectedExam!.dateTime}"),
          Text("Location: ${_selectedExam!.location}"),
          Text("Duration: ${_selectedExam!.duration} minutes"),
          Text("Total Questions: ${_selectedExam!.totalQuestions}"),
          Text("Options per Question: ${_selectedExam!.optionsPerQuestion}"),
        ],
      ],
    );
  }
}

