import 'package:flutter/material.dart';
import 'package:quizapp/Screens/candidate/candidatepage.dart';
import 'package:quizapp/Screens/exam/examCreatePage.dart';
import 'package:quizapp/Screens/exam/examScreen.dart';
import 'package:quizapp/Screens/omr/omrCreatePage.dart';
import 'package:quizapp/Screens/question/questionScreen.dart';
import 'package:quizapp/Screens/scholar/scholarScreen.dart';
import 'package:quizapp/Widgets/examCard.dart';
import 'package:quizapp/Widgets/menuButton.dart';
import 'package:quizapp/Screens/question/questionCreatePage.dart';
import 'package:quizapp/Widgets/shortcutButton.dart';
import 'package:quizapp/constant.dart';
import 'package:collection/collection.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List _menuOptions = [
      {
        "title": "New Exam",
        "image": "assets/images/thirteen.svg",
      },
      {
        "title": "Register Candidate",
        "image": "assets/images/fourteen.svg",
      },
      {
        "title": "Add Question",
        "image": "assets/images/sixteen.svg",
      },
      {
        "title": "OMR Generate",
        "image": "assets/images/three.svg",
      },
    ];
    List _shortcutMenu = [
      {
        "title": "Exams",
        "image": "assets/images/one.svg",
      },

      {
        "title": "Scholars",
        "image": "assets/images/nine.svg",
      },
      {
        "title": "Question",
        "image": "assets/images/two.svg",
      },
      {
        "title": "Results",
        "image": "assets/images/eleven.svg",
      },
      {
        "title": "Schools",
        "image": "assets/images/four.svg",
      },


    ];
    final List<Widget> _menuoptions = [
      const ExamCreatePage(),
      const CandidateCreatePage(),
      const QuestionCreatePage(),
      const OmrCreatePage(),
    ];

    final List<Widget> _shortcutOptions = [
      ExamScreen(),
      const ScholarScreen(),
      //QuestionScreen(),

      //QuestionScreen(),
      //const QuestionCreatePage()
    ];

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: neutralBG,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset("assets/images/leading2.png", width: 50),
                  const Text(
                    "Search Query",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  labelText: "type here...",
                  hintText: "O Level Final",
                  hintStyle: const TextStyle(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 5),
                    child: Icon(Icons.terminal_sharp,
                        size: 30, color: Colors.brown[800]),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 3.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 3.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 3.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.red, width: 3.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.red, width: 3.5),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Row(
              children: [
                Icon(Icons.menu_open, color: appTextPrimary),
                Text(
                  "Menu",
                  style: TextStyle(
                      color: appTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: _menuOptions.mapIndexed((index, e) {
              return MenuButton(
                title: e['title'],
                image: e['image'],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _menuoptions[index]),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 12),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.shortcut, color: colorPrimary),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Shortcuts",
                  style: TextStyle(
                      color: appTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ],
        ),

        //shortcuts ...
        const SizedBox(height: 7),
        SizedBox(
          height: 116,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _shortcutOptions.length,
            itemBuilder: (BuildContext context, int index) {
              //will replaced by shortcut buttons
              return Row(
                children: [
                  ShortcutButton(
                    title: _shortcutMenu[index]['title'],
                    image: _shortcutMenu[index]['image'],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _shortcutOptions[index]),
                    ),
                  ),
                  //SizedBox(width: 10,)
                ],
              );
            },
          ),
        ),

        //most recent activities
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.manage_history, color: colorPrimary),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Recent Activity",
                  style: TextStyle(
                      color: appTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        ExamCard(
          examId: 1,
          examName: "Space X Journey To Mars",
          examDate: DateTime.parse("2024-12-30T18:00:00.000Z"),
          examLocation: "Planet Earth",
          examDuration: 5,
          questionCount: 100,
          candidateCount: 100,
          onDelete: (){},
        )
      ],
    );
  }
}
