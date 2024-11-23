import 'package:flutter/material.dart';
import 'package:quizapp/Screens/candidate/candidateAddPage.dart';
import 'package:quizapp/constant.dart';

class CandidateCreatePage extends StatefulWidget {
  const CandidateCreatePage({super.key});

  @override
  State<CandidateCreatePage> createState() => _CandidateCreatePage();
}

class _CandidateCreatePage extends State<CandidateCreatePage> with SingleTickerProviderStateMixin{
  int _selectedIndex = 0; // To track the selected tab
  late TabController _tabController;

  // List of widgets for each section
  final List<Widget> _widgetOptions = <Widget>[
    CandidateEditor(),
    Center(child: Text("preview"),),
  ];

  @override
  void initState() {
    super.initState();
    // Ensure the TabController length matches the number of tabs and views
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
        title: const Text(
          "Candidate Registration",
          style: TextStyle(color: appTextPrimary),
        ),
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: appTextPrimary),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
        child: TabBarView(
          controller: _tabController,
          children: _widgetOptions,
        ),
      ), // Display the selected widget
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: neutralBG,
        ),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: brandMinus2, // Green color for the selected tab
            borderRadius: BorderRadius.circular(10), // Optional rounded corners
          ),
          indicatorSize: TabBarIndicatorSize.tab, // Ensures the indicator spans the full tab width
          labelPadding: EdgeInsets.zero, // Removes padding around the label
          labelColor:colorPrimary, // Text and icon color for the selected tab
          unselectedLabelColor: Colors.grey, // Text and icon color for unselected tabs
          tabs: const [
            Tab(icon: Icon(Icons.edit_note), text: "Editor"),
            Tab(icon: Icon(Icons.preview), text: "Preview"),
          ],
        ),
      ),
    );
  }
}
