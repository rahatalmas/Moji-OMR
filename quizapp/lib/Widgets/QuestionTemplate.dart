import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/providers/questionProvider.dart';

class QuestionTemplate extends StatelessWidget {
  const QuestionTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, questionProvider, child) {
        // Check if there are questions
        if (questionProvider.questions.isEmpty) {
          return const Center(child: Text('No questions added yet.'));
        }

        return ListView.builder(
          itemCount: questionProvider.questions.length,
          itemBuilder: (context, index) {
            final question = questionProvider.questions[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Q${index + 1}: ${question.questionText}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    ...question.options.asMap().entries.map((entry) {
                      final optionIndex = entry.key;
                      final option = entry.value;
                      return Text(
                        'Option ${String.fromCharCode(65 + optionIndex)}: $option',
                        style: const TextStyle(fontSize: 14),
                      );
                    }).toList(),
                    const SizedBox(height: 5),
                    Text(
                      'Correct Answer: ${question.correctAnswer}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
