import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String? _selectedAnswer;
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(4, (_) => TextEditingController());

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

  void _addQuestion() {
    final question = _questionController.text;
    final options = _optionControllers.map((controller) => controller.text).toList();

    // Check if any field is empty
    if (question.isEmpty || options.any((option) => option.isEmpty) || _selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and select an answer.')),
      );
      return;
    }

    // If all fields are filled, print the data
    print('Question: $question');
    print('Options: ${options.join(', ')}');
    print('Selected Answer: $_selectedAnswer');

    // Reset the fields
    _questionController.clear();
    for (var controller in _optionControllers) {
      controller.clear();
    }
    setState(() {
      _selectedAnswer = null; // Reset selected answer
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.question_answer_outlined),
                            Text(
                              "Question Maker",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Edit",
                              style: TextStyle(fontSize: 17),
                            ),
                            Icon(Icons.settings, size: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Text("Total: 10"),
                        SizedBox(width: 20),
                        Text("Added: 7"),
                        SizedBox(width: 20),
                        Text("Remaining: 3"),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Text("Options per Question: 4"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Question- 1",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        _buildCircle(Colors.orange),
                        SizedBox(width: 5),
                        _buildCircle(Colors.blue),
                        SizedBox(width: 5),
                        _buildCircle(Colors.green),
                      ],
                    ),
                  ],
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
                for (int i = 0; i < 4; i++) ...[
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
                  const SizedBox(height: 10), // Add spacing after each option
                ],
                const Text(
                  "Select correct answer",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _answerCircle(context, 'A'),
                    _answerCircle(context, 'B'),
                    _answerCircle(context, 'C'),
                    _answerCircle(context, 'D'),
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
}
