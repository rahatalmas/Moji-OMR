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
      providers:[
        ChangeNotifierProvider(create: (context)=>QuestionProvider()),
        ChangeNotifierProvider(create: (context)=>ActionStatusProvider())
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool editModeOn = Provider.of<ActionStatusProvider>(context,listen: true).actionInfo;
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 5,
            shadowColor: Colors.black,
            //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: kColorPrimary,
            title: Text("Moji OMR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: kColorSecondary),),
            actions: [
              Icon(Icons.content_paste_search,color: Color(0xFFEEEEEE),),
              SizedBox(width: 10,),
              editModeOn?InkWell(
                  child:Icon(Icons.sunny, color: Color(0xFFEEEEEE),),
                  onTap: (){
                    Provider.of<ActionStatusProvider>(context,listen: false).turnActionStatusOff();
                  }
              ):Icon(Icons.mode_night,color: Color(0xFFEEEEEE),),
              SizedBox(width: 15,)
            ],
          ),
          body: Padding(
            padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
    );
  }
}
