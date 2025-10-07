import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/omr/updateAnswerScreen.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/answer.dart';
import 'package:quizapp/database/models/exammodel.dart';
import 'package:quizapp/providers/answerProvider.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/routes.dart';
import '../../Widgets/examFilter.dart';

class OmrCreatePage extends StatefulWidget {
  const OmrCreatePage({super.key});

  @override
  State<OmrCreatePage> createState() => _OmrCreatePage();
}

class _OmrCreatePage extends State<OmrCreatePage> {
  final _selectedAnswers = {};
  List<int> l = List.filled(81, 0);

  void _handleCreateButtonPress(Exam? exam) async {
    final answerProvider = Provider.of<AnswerProvider>(context, listen: false);
    if (_selectedAnswers.length < exam!.totalQuestions) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select answers for all questions."),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      for (int i = 0; i < exam.totalQuestions; i++) {
        final answer = Answer(
            examId: exam.id,
            questionSetId: 1,
            questionNumber: i + 1,
            correctAnswer: l[i + 1]);
        await answerProvider.addAnswer(answer);
      }
      answerProvider.getAllAnswers(exam.id);
      if (!mounted) return;
      Navigator.pushNamed(context, RouteNames.viewDocument);
    }
  }

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context, listen: true);
    final answerProvider = Provider.of<AnswerProvider>(context, listen: true);
    final totalQuestions = examProvider.selectedExam?.totalQuestions ?? 0;
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
      ),
      backgroundColor: neutralWhite,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: ExamFilterWidget(),
          ),
          examProvider.selectedExam == null
              ? const Expanded(
                  child: Center(
                    child: Text("no exam selected"),
                  ),
                )
              : answerProvider.answers.length !=
                      examProvider.selectedExam!.totalQuestions
                  ? answerProvider.isLoading
                      ?
                      //loader
                      Expanded(
                          child: Center(
                            child: Lottie.asset(
                              "assets/images/animations/geometryloader.json",
                              width: 100,
                            ),
                          ),
                        )
                      :
                      //answer list for storing
                      Expanded(
                          child: ListView(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.list),
                                        SizedBox(width: 3),
                                        Text("Select Correct Answer"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: totalQuestions,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text('Question: ${index + 1}'),
                                                const SizedBox(width: 20),
                                              ],
                                            ),
                                            AnswerCircles(
                                              questionNumber: index + 1,
                                              onAnswerSelected:
                                                  (int question, int answer) {
                                                setState(() {
                                                  _selectedAnswers[question] =
                                                      answer;
                                                  l[question] = answer;
                                                });
                                                print(l);
                                                print(
                                                  _selectedAnswers,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                  :
                  //answer is set
                  Expanded(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Lottie.asset(
                                  "assets/images/animations/answerchecked.json",
                                  height: 300,
                                ),
                                const Text("Answers Are Set")
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UpdateAnswerScreen(
                                      exam: examProvider.selectedExam!);
                                }));
                              },
                              child: const Text(
                                "Update answer",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
          examProvider.selectedExam == null
              ? Container()
              : answerProvider.isLoading
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: neutralWhite,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          answerProvider.answers.length !=
                                  examProvider.selectedExam!.totalQuestions
                              ? _handleCreateButtonPress(
                                  examProvider.selectedExam,
                                )
                              : Navigator.pushNamed(
                                  context,
                                  RouteNames.viewDocument,
                                );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "Download",
                              style: TextStyle(
                                color: neutralWhite,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

class AnswerCircles extends StatefulWidget {
  final int questionNumber; // Question number passed from parent
  final void Function(int question, int answer) onAnswerSelected;

  const AnswerCircles({
    super.key,
    required this.questionNumber,
    required this.onAnswerSelected,
  });

  @override
  State<AnswerCircles> createState() => _AnswerCirclesState();
}

class _AnswerCirclesState extends State<AnswerCircles> {
  String? _selectedAnswer;

  void _handleAnswerSelection(String label) {
    setState(() {
      _selectedAnswer = label;
    });

    // Convert A-D to 0-3
    int answerIndex = (label.codeUnitAt(0) - 65) + 1;

    // Notify parent about the selected answer
    widget.onAnswerSelected(widget.questionNumber, answerIndex);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label selected'),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: neutralWhite,
        border: BorderDirectional(
          bottom: BorderSide(color: neutralBG, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < 4; i++)
            AnswerCircle(
              label: String.fromCharCode(65 + i),
              isSelected: _selectedAnswer == String.fromCharCode(65 + i),
              onTap: _handleAnswerSelection,
            ),
        ],
      ),
    );
  }
}

class AnswerCircle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(String) onTap;

  const AnswerCircle({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.green : Colors.blue,
          border: Border.all(color: kColorPrimary),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? neutralWhite : kColorPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
