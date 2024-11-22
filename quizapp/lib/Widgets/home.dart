import 'package:flutter/material.dart';
import 'package:quizapp/Screens/candidate/candidatepage.dart';
import 'package:quizapp/Screens/exam/examCreatePage.dart';
import 'package:quizapp/Screens/omr/omrCreatePage.dart';
import 'package:quizapp/Widgets/menuButton.dart';
import 'package:quizapp/Widgets/omrCreatePage.dart';
import 'package:quizapp/Screens/question/questionCreatePage.dart';
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
      {
        "title": "Result",
        "image": "assets/images/four.svg",
      },
    ];

    final List<Widget> _menuoptions = [
      const ExamCreatePage(),
      const CandidateCreatePage(),
      const QuestionCreatePage(),
      const omrCreatePage(),
      const Center(child: Text("Result Generator")),
    ];

    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: kColorSecondary2,
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
                    "Enter the name of Examination",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
        Wrap(
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
        // Menu Section
        //
        // Row(
        //   children: [
        //     MenuButton(
        //       title: "Create Exam",
        //       image: "assets/images/leading4.png",
        //       onTap: () => changeMenu(0),
        //     ),
        //     const SizedBox(width: 10),
        //     MenuButton(
        //       title: "Register Candidate",
        //       image: "assets/images/leading3.png",
        //       onTap: () => changeMenu(1),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 10),
        // Row(
        //   children: [
        //     MenuButton(
        //       title: "Create Question",
        //       image: "assets/images/leading4.png",
        //       onTap: () => changeMenu(2),
        //     ),
        //     const SizedBox(width: 10),
        //     MenuButton(
        //       title: "Generate OMR",
        //       image: "assets/images/leading3.png",
        //       onTap: () => changeMenu(3),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 10),
        // Row(
        //   children: [
        //     MenuButton(
        //       title: "Check paper",
        //       image: "assets/images/leading4.png",
        //       onTap: () => changeMenu(2),
        //     ),
        //     const SizedBox(width: 10),
        //     MenuButton(
        //       title: "Pending exams",
        //       image: "assets/images/leading3.png",
        //       onTap: () => changeMenu(3),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 10),

        // History Section
        // Row(
        //   children: [
        //     Row(
        //       children: [
        //         Icon(Icons.history, color: kColorPrimary),
        //         const SizedBox(width: 2),
        //         Text(
        //           "History",
        //           style: TextStyle(
        //               color: kColorPrimary,
        //               fontWeight: FontWeight.bold,
        //               fontSize: 15),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 10),
        // Row(
        //   children: [
        //     MenuButton(
        //       title: "Past Exams",
        //       image: "assets/images/leading4.png",
        //       onTap: () => changeMenu(0),
        //     ),
        //     const SizedBox(width: 10),
        //     MenuButton(
        //       title: "Results List",
        //       image: "assets/images/leading3.png",
        //       onTap: () => changeMenu(1),
        //     ),
        //   ],
        // ),

        const SizedBox(height: 12),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.shortcut, color: colorPrimary),
                SizedBox(width: 3,),
                Text(
                  "Shortcuts",
                  style: TextStyle(
                      color: appTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ],
            ),
          ],
        ),

        //shortcuts ...
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              //will replaced by shortcut buttons
              return Container(
                width: 120,
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: neutralBG,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 0.1)]
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
