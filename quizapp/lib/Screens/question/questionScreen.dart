import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizapp/Widgets/questionCard.dart';
import 'package:quizapp/constant.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
        actions: const [
          Icon(Icons.add),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: neutralWhite,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: neutralBG,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: 1, // Spread of shadow
                      offset: Offset.zero, // Shadow is even on all sides
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.newspaper,
                          color: colorPrimary,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "All Time",
                          style: TextStyle(color: colorPrimary),
                        )
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/images/filter.svg",
                      height: 20,
                      color: colorPrimary,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const QuestionCard(
                    questionId: 1,
                    questionName: "Nasa x Tesla space challenge",
                    questionPicture: null,
                    numberOfQuestions: 200,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
