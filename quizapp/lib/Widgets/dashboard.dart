import 'package:flutter/material.dart';
import 'package:quizapp/Widgets/menuButton.dart';
import 'package:quizapp/Widgets/omrCreatePage.dart';
import 'package:quizapp/Widgets/questionCreatePage.dart';
import 'package:quizapp/constant.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> _menuoptions = [
      const Center(child: Text("Create exam")),
      const QuestionCreatePage(),
      const OmrCreatePage(),
      const Center(child: Text("Result Generator")),
    ];

    void changeMenu(int index) {
      // Print the selected menu based on the index
      print("Selected menu index: $index");
      print("Navigating to: ${_menuoptions[index]}");

      // Example navigation logic based on the index
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _menuoptions[index]),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: kColorSecondary2,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                      borderSide: const BorderSide(color: Colors.black, width: 3.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.black, width: 3.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.black, width: 3.5),
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
          const SizedBox(height: 10),

          // Menu Section
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.menu_open, color: kColorPrimary),
                  Text(
                    "Menu",
                    style: TextStyle(
                        color: kColorPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              MenuButton(
                title: "Create Exam",
                image: "assets/images/leading4.png",
                onTap: () => changeMenu(0),
              ),
              const SizedBox(width: 10),
              MenuButton(
                title: "Set Question",
                image: "assets/images/leading3.png",
                onTap: () => changeMenu(1),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              MenuButton(
                title: "Generate OMR",
                image: "assets/images/leading4.png",
                onTap: () => changeMenu(2),
              ),
              const SizedBox(width: 10),
              MenuButton(
                title: "Paper Check",
                image: "assets/images/leading3.png",
                onTap: () => changeMenu(3),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // History Section
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.history, color: kColorPrimary),
                  const SizedBox(width: 2),
                  Text(
                    "History",
                    style: TextStyle(
                        color: kColorPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              MenuButton(
                title: "Past Exams",
                image: "assets/images/leading4.png",
                onTap: () => changeMenu(0),
              ),
              const SizedBox(width: 10),
              MenuButton(
                title: "Results List",
                image: "assets/images/leading3.png",
                onTap: () => changeMenu(1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
