import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/providers/actionProvider.dart';
import 'package:quizapp/providers/questionProvider.dart';

import '../database/models/question.dart';

class QuestionCreatePage extends StatefulWidget {
  const QuestionCreatePage({super.key});

  @override
  State<QuestionCreatePage> createState() => _QuestionCreatePage();
}

class _QuestionCreatePage extends State<QuestionCreatePage> {
  String? _selectedAnswer;
  final TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _optionControllers = [];
  int totalQuestions = 10; // Default total questions
  int optionsPerQuestion = 4; // Default options per question
  int currentQuestionIndex = 1; // To track the current question number

  @override
  void initState() {
    super.initState();
    _initializeOptionControllers();
  }

  void _initializeOptionControllers() {
    _optionControllers = List.generate(optionsPerQuestion, (_) => TextEditingController());
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _answerCircle(BuildContext context, String label) {
    final isSelected = _selectedAnswer == label;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedAnswer = label;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label selected'), duration: Duration.zero),
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
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _setTotalAndOptions() {
    final TextEditingController totalQuestionsController = TextEditingController();
    final TextEditingController optionsController = TextEditingController();
    bool showError = false;
    String errorMessage = '';

    bool isReset = Provider.of<QuestionProvider>(context, listen: false).questions.isNotEmpty;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Set Total Questions and Options"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: totalQuestionsController,
                    decoration: InputDecoration(labelText: "Total Questions"),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: optionsController,
                    decoration: InputDecoration(labelText: "Options per Question"),
                    keyboardType: TextInputType.number,
                  ),
                  if (showError) ...[
                    SizedBox(height: 10),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            if (isReset) ...[
              TextButton(
                onPressed: () {
                  // Reset action
                  Provider.of<QuestionProvider>(context, listen: false).resetQuestions();
                  setState(() {
                    totalQuestions = int.tryParse(totalQuestionsController.text) ?? 10;
                    int? parsedOptions = int.tryParse(optionsController.text);
                    if (parsedOptions != null && parsedOptions >= 2 && parsedOptions <= 6) {
                      optionsPerQuestion = parsedOptions;
                      showError = false; // Valid input
                      errorMessage = '';
                      _initializeOptionControllers();
                      currentQuestionIndex = 1; // Reset question index
                      Navigator.of(context).pop(); // Close dialog
                    } else {
                      showError = true; // Show error if invalid
                      errorMessage = 'Please enter a valid number of options (2-6).';
                    }
                  });
                },
                child: Text("Reset"),
              ),
            ],
            TextButton(
              onPressed: () {
                int? parsedOptions = int.tryParse(optionsController.text);
                if (Provider.of<QuestionProvider>(context, listen: false).questions.isNotEmpty) {
                  showError = true;
                  errorMessage = 'To change options, please reset the added questions.';
                } else if (totalQuestionsController.text.isNotEmpty && int.tryParse(totalQuestionsController.text)! < Provider.of<QuestionProvider>(context, listen: false).questions.length) {
                  showError = true;
                  errorMessage = 'You cannot decrease the total number of questions after adding them.';
                } else if (parsedOptions != null && parsedOptions >= 2 && parsedOptions <= 6) {
                  setState(() {
                    totalQuestions = int.tryParse(totalQuestionsController.text) ?? totalQuestions;
                    optionsPerQuestion = parsedOptions;
                    showError = false; // Valid input
                    errorMessage = '';
                    _initializeOptionControllers();
                    currentQuestionIndex = 1; // Reset question index
                  });
                  Navigator.of(context).pop(); // Close dialog
                } else {
                  showError = true; // Show error for invalid input
                  errorMessage = 'Please enter a valid number of options (2-6).';
                }
              },
              child: Text("Set"),
            ),
          ],
        );
      },
    );
  }


  void _addQuestion() {
    final question = _questionController.text;
    final options = _optionControllers.map((controller) => controller.text).toList();

    if (question.isEmpty || options.any((option) => option.isEmpty) || _selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(duration: Duration.zero, content: Text('Please fill in all fields and select an answer.')),
      );
      return;
    }

    // Create a new Question object
    final newQuestion = Question(
      questionText: question,
      options: options,
      correctAnswer: _selectedAnswer!,
    );

    // Use the provider to add the question
    Provider.of<QuestionProvider>(context, listen: false).addQuestion(newQuestion);
    Provider.of<ActionStatusProvider>(context,listen: false).turnActionStatusOn();
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
    final addedQuestions = Provider.of<QuestionProvider>(context).questions.length;
    final remainingQuestions = totalQuestions - addedQuestions;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.black87, width: 2),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.question_answer_outlined),
                            Text(
                              "Question Maker ",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: _setTotalAndOptions,
                          child: Row(
                            children: [
                              Text(
                                "Edit",
                                style: TextStyle(fontSize: 17),
                              ),
                              Icon(Icons.settings, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Total: $totalQuestions"),
                        SizedBox(width: 20),
                        Text("Added: $addedQuestions"),
                        SizedBox(width: 20),
                        Text("Remaining: $remainingQuestions"),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text("Options per Question: $optionsPerQuestion"),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: Image.asset(
                    "assets/images/brainchip.png",
                    height: 35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question - $currentQuestionIndex",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Type Your Question",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    labelText: "Question",
                    hintText: "Type Question",
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.question_mark, size: 10, color: Colors.brown[800]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.brown, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
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
                    decoration: InputDecoration(
                      labelText: "Option ${String.fromCharCode(65 + i)}",
                      hintText: "Enter text here",
                      prefixIcon: Icon(Icons.circle, size: 10, color: Colors.brown[800]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.brown, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.brown, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                const Text(
                  "Select correct answer",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < optionsPerQuestion; i++)
                      if (i < 6) // Ensure we only create up to 6 options
                        _answerCircle(context, String.fromCharCode(65 + i)), // Create circles A, B, C, D, etc.
                  ],
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: _addQuestion,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.black87, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
