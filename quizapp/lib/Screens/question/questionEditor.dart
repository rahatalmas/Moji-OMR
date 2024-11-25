import 'package:flutter/material.dart';
import 'package:quizapp/Screens/exam/dummyExamList.dart';
import 'package:quizapp/Widgets/answerCircle.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/models/exammodel.dart';
import 'package:quizapp/models/question.dart';

class QuestionEditor extends StatefulWidget {
  const QuestionEditor({super.key});

  @override
  State<QuestionEditor> createState() => _QuestionEditor();
}

class _QuestionEditor extends State<QuestionEditor> {
  String? _selectedAnswer;
  void _handleAnswerSelection(String label) {
    setState(() {
      _selectedAnswer = label;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label selected')),
    );
  }
  final TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _optionControllers = [];
  int totalQuestions = 10; // Default total questions
  int optionsPerQuestion = 4; // Default options per question
  int currentQuestionIndex = 1; // To track the current question number
  Exam? _selectedExam; // Store the selected exam

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: const Icon(Icons.input, size: 30, color: kColorPrimary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    fillColor: Colors.white,
    filled: true,
  );

  @override
  void initState() {
    super.initState();
    _initializeOptionControllers();
  }

  //option editor
  void _initializeOptionControllers() {
    _optionControllers =
        List.generate(optionsPerQuestion, (_) => TextEditingController());
  }
  // for exam selection
  void _onExamSelected(Exam exam) {
    setState(() {
      _selectedExam = exam;
      totalQuestions = exam.totalQuestions;
    });
  }


  //answer circle widget
  /*idget _answerCircle(BuildContext context, String label) {
    final isSelected = _selectedAnswer == label;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedAnswer = label;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label selected')),
        );
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.green : Colors.blue,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }*/

  void _addQuestion() {
    final question = _questionController.text;
    final options =
    _optionControllers.map((controller) => controller.text).toList();

    if (question.isEmpty ||
        options.any((option) => option.isEmpty) ||
        _selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields and select an answer.')),

      );
      return;
    }

    // Create a new Question object
    final newQuestion = Question(
      questionText: question,
      options: options,
      correctAnswer: _selectedAnswer!,
    );

    // Reset the fields
    _questionController.clear();
    for (var controller in _optionControllers) {
      controller.clear();
    }
    setState(() {
      _selectedAnswer = null; // Reset selected answer
      currentQuestionIndex++; // Increment the current question index
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExamFilterWidget(
              examList: examList,
              onExamSelected: (exam) {
                _onExamSelected(exam);
              },
            ),

            const SizedBox(height: 10),
            _selectedExam == null
                ? Center(
              child: Column(
                children: [
                  Image.asset("assets/images/leading1.png",height: 300,width: 300,),
                  SizedBox(height: 25,),
                  Text("Select an exam to add Question",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)
                ],
              ),
            )
                :
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration:const BoxDecoration(
                color: neutralBG,
                borderRadius:  BorderRadius.all(Radius.circular(10)),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Question - ${1}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Type Your Question",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _questionController,
                    decoration: _textFieldDecoration.copyWith(
                      labelText: "Question",
                      hintText: "Type Question",
                      prefixIcon: const Icon(Icons.question_mark,
                          size: 24, color: kColorPrimary),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Type Options",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  for (int i = 0; i < optionsPerQuestion; i++) ...[
                    TextField(
                      controller: _optionControllers[i],
                      decoration: _textFieldDecoration.copyWith(
                        labelText: "Option ${String.fromCharCode(65 + i)}",
                        hintText: "Enter text here",
                        prefixIcon: Icon(Icons.circle,
                            size: 16, color: Colors.brown[800]),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  const Text(
                    "Select correct answer",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  //circles for correct answer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < optionsPerQuestion; i++)
                       // An(context, String.fromCharCode(65 + i)),
                       AnswerCircle(
                           label: String.fromCharCode(65 + i),
                           isSelected: _selectedAnswer ==  String.fromCharCode(65 + i),
                           onTap: _handleAnswerSelection)
                    ],
                  ),
                  const SizedBox(height: 15),

                  //adding button
                  InkWell(
                    onTap: _addQuestion,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.black87, width: 2),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(Icons.add, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
