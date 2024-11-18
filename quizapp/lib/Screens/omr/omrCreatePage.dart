import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';

class omrCreatePage extends StatefulWidget {
  const omrCreatePage({super.key});

  @override
  State<omrCreatePage> createState() => _CandidateCreatePage();
}

class _CandidateCreatePage extends State<omrCreatePage> {
  int _selectedIndex = 0; // To track the selected tab

  // List of widgets for each section
  final List<Widget> _widgetOptions = <Widget>[
    Center(child: Text("editor"),),
    Center(child: Text("preview"),),
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
          "OMR creator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
