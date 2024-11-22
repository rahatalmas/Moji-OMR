import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Widgets/adminPage.dart';
import 'package:quizapp/Widgets/home.dart';
import 'package:quizapp/providers/actionProvider.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/questionProvider.dart';

import 'constant.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExamProvider()),
        ChangeNotifierProvider(create: (context) => QuestionProvider()),
        ChangeNotifierProvider(create: (context) => ActionStatusProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: KeyboardDismissOnTap(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Moji OMR',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const Root(title: 'MOJI OMR'),
        ),
      ),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key, required this.title});
  final String title;

  @override
  State<Root> createState() => _Root();
}

class _Root extends State<Root> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _children = [
    const Dashboard(),
    const Center(child: Text("Result Generator")),
  ];

  // Global key to access the scaffold state
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Ensure the TabController length matches the number of tabs and views
    _tabController = TabController(length: _children.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool editModeOn = Provider.of<ActionStatusProvider>(context, listen: true).actionInfo;

    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key
      backgroundColor: neutralWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: neutralWhite,
        leading: IconButton(
          icon: Icon(Icons.menu, color: appTextPrimary, size: 28),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: appTextPrimary),
        ),
        actions: [
          Icon(Icons.content_paste_search, color: appTextPrimary),
          const SizedBox(width: 10),
          editModeOn
              ? InkWell(
            child: Icon(Icons.sunny, color: appTextPrimary),
            onTap: () {
              Provider.of<ActionStatusProvider>(context, listen: false).turnActionStatusOff();
            },
          )
              : Icon(Icons.mode_night, color: appTextPrimary),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
        child: TabBarView(
          controller: _tabController,
          children: _children,
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
        decoration: BoxDecoration(
          color: neutralBG,
              borderRadius: BorderRadius.circular(12)
        ),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: brandMinus2, // Green color for the selected tab
            borderRadius: BorderRadius.circular(12), // Optional rounded corners
          ),
          indicatorSize: TabBarIndicatorSize.tab, // Ensures the indicator spans the full tab width
          labelPadding: EdgeInsets.zero, // Removes padding around the label
          labelColor:brandPlus2,
          // Text and icon color for the selected tab
          unselectedLabelColor: Colors.grey, // Text and icon color for unselected tabs
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.sailing), text: "Result"),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: kColorSecondary,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kColorPrimary,
              ),
              accountName: const Text("Admin"),
              accountEmail: const Text("Admin@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: kColorPrimary,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/leading3.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Admin"),
              onTap: () {
                Navigator.pop(context);
                _tabController.animateTo(0); // Navigate to the Admin Page
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text("All Exams"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("All Results"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text("All Questions"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
