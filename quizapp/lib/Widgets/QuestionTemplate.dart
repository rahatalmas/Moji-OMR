import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/providers/questionProvider.dart';

import '../utils/pdfGenerator.dart';

class QuestionTemplate extends StatelessWidget {
  const QuestionTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, questionProvider, child) {
        // Check if there are questions
        if (questionProvider.questions.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/worker.png",),
              SizedBox(height: 20,),
              Text("Nothing to Preview",style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color: Colors.black87),)
            ],
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questionProvider.questions.length,
                itemBuilder: (context, index) {
                  final question = questionProvider.questions[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q${index + 1}: ${question.questionText}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          ...question.options.asMap().entries.map((entry) {
                            final optionIndex = entry.key;
                            final option = entry.value;
                            return Text(
                              'Option ${String.fromCharCode(65 + optionIndex)}: $option',
                              style: const TextStyle(fontSize: 14),
                            );
                          }),
                          const SizedBox(height: 5),
                          Text(
                            'Correct Answer: ${question.correctAnswer}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: double.infinity, // Make button take full width
                child: ElevatedButton(
                  onPressed: () {
                    PdfGenerator.generatePdf(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Set your desired border radius
                    ),
                  ),
                  child: const Text('Generate PDF'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
