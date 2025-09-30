import 'package:flutter/material.dart';
import 'package:quizapp/Screens/question/QuestionTemplate.dart';
import 'package:quizapp/Screens/question/questionEditor.dart';
import 'package:quizapp/constant.dart';

class QuestionCreatePage extends StatefulWidget {
  const QuestionCreatePage({super.key});

  @override
  State<QuestionCreatePage> createState() => _QuestionCreatePage();
}

class _QuestionCreatePage extends State<QuestionCreatePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _widgetOptions = const [QuestionEditor(), QuestionTemplate()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _widgetOptions.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: neutralWhite,
        title: const Text(
          "Question Creation",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: neutralWhite,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: TabBarView(
          controller: _tabController,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: neutralBG,
        ),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: brandMinus2,
            borderRadius: BorderRadius.circular(10),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.zero,
          labelColor: colorPrimary,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(icon: Icon(Icons.edit_note), text: "Editor"),
            Tab(icon: Icon(Icons.preview), text: "Preview"),
          ],
        ),
      ),
    );
  }
}
