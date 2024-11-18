import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/question/QuestionTemplate.dart';
import 'package:quizapp/Screens/question/questionEditor.dart';
import 'package:quizapp/constant.dart';

class QuestionCreatePage extends StatefulWidget {
  const QuestionCreatePage({super.key});

  @override
  State<QuestionCreatePage> createState() => _QuestionCreatePage();
}

class _QuestionCreatePage extends State<QuestionCreatePage> {
  int _selectedIndex = 0; // To track the selected tab

  // List of widgets for each section
  final List<Widget> _widgetOptions = <Widget>[
    QuestionEditor(),
    QuestionTemplate()
  ];

  // Method to handle bottom navigation tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Question Creation",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: kColorSecondary,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _widgetOptions[_selectedIndex],
      ), // Display the selected widget
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kColorPrimary,
        selectedItemColor: kColorSecondary,
        unselectedItemColor: kColorSecondary2,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.preview),
            label: 'Preview',
          ),
        ],
      ),
    );
  }
}
