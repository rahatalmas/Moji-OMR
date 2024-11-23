import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';

class omrCreatePage extends StatefulWidget {
  const omrCreatePage({super.key});

  @override
  State<omrCreatePage> createState() => _CandidateCreatePage();
}

class _CandidateCreatePage extends State<omrCreatePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        title: const Text(
          "OMR creator",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: neutralWhite,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text("Omr generator"),
        ),
      ), // Display the selected widget
    );
  }
}
