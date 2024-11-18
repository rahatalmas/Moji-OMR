import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Widgets/adminPage.dart';
import 'package:quizapp/Widgets/dashboard.dart';
import 'package:quizapp/providers/actionProvider.dart';
import 'package:quizapp/providers/questionProvider.dart';

import 'constant.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
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

class _Root extends State<Root> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Dashboard(),
    const Center(child: Text("Result Generator"),),
    const AdminPage()
  ];
  late bool editMode;

  // Global key to access the scaffold state
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool editModeOn = Provider.of<ActionStatusProvider>(context, listen: true).actionInfo;
    return Scaffold(
      key: _scaffoldKey,  // Assign the scaffold key
      backgroundColor: kColorSecondary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: kColorPrimary,
        leading: IconButton(
          icon: Icon(Icons.menu, color: appBarText, size: 28),
          onPressed: () {
            // Open the drawer when the menu icon is tapped
            _scaffoldKey.currentState?.openDrawer();  // Use the scaffold key to open the drawer
          },
        ),
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: appBarText),
        ),
        actions: [
          Icon(Icons.content_paste_search, color: appBarText),
          SizedBox(width: 10),
          editModeOn
              ? InkWell(
              child: Icon(Icons.sunny, color: appBarText),
              onTap: () {
                Provider.of<ActionStatusProvider>(context, listen: false).turnActionStatusOff();
              })
              : Icon(Icons.mode_night, color: appBarText),
          SizedBox(width: 15)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: _children[_currentIndex],
      ), // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: kColorPrimary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
            backgroundColor: kColorPrimary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.sailing),
            label: 'Result',
            backgroundColor: Colors.indigo[900],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Admin',
            backgroundColor: Colors.indigo[900],
          ),
        ],
      ),
      // Add Drawer Navigation
      drawer: Drawer(
        backgroundColor: kColorSecondary, // Set background color for the drawer
        child: Column(
          children: [
            // User Info Section (Avatar + Name) - Set header color to kPrimary
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kColorPrimary, // Set the header background color to kColorPrimary
              ),
              accountName: const Text("Admin"), // Replace with dynamic name if needed
              accountEmail: const Text("Admin@gmail.com"), // Replace with dynamic email if needed
              currentAccountPicture: CircleAvatar(
                backgroundColor: kColorPrimary,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/leading3.png', // Replace with the path to the user's avatar image
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Drawer Menu Items with a background color of kColorSecondary2
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Admin"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _currentIndex = 2; // Navigate to the Admin Page
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text("All Exams"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to All Exams (Implement the page if needed)
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("All Results"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to All Results (Implement the page if needed)
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text("All Questions"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to All Questions (Implement the page if needed)
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Perform logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
