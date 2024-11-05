import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Widgets/QuestionTemplate.dart';
import 'package:quizapp/Widgets/createPage.dart';
import 'package:quizapp/Widgets/questionCreatePage.dart';
import 'package:quizapp/Widgets/omrCreatePage.dart';
import 'package:quizapp/providers/questionProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context)=>QuestionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moji OMR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const Root(title: 'MOJI OMR'),
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
  bool editMode = false;
  late List<Widget> components;

  late final List<Widget> _children;

  @override
  void initState() {
    super.initState();

    components = [
      CreatePage(updateComponent: updateComponent),
      const QuestionCreatePage(),
      const OmrCreatePage(),
    ];

    _children = [
      components[0],
      const QuestionTemplate(),
      const QuestionCreatePage(),
    ];
  }
  void updateComponent(int index) {
    setState(() {
      _children[0] = components[index];
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if(editMode==false){
        updateComponent(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black,
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.yellow[200],
        title: Image.asset("assets/images/logotemp2.png",width: 150,),
        //title: Text("MOJI OMR"),
        //leading:Image.asset("assets/images/leading2.png"),
        actions: const [
          Icon(Icons.content_paste_search),
          SizedBox(width: 10,),
          Icon(Icons.mode_night),
          SizedBox(width: 15,)
        ],
      ),
      body: Padding(
          padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: _children[_currentIndex],
      ), // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.yellow[200],
        onTap: onTabTapped,
        items:const [
          BottomNavigationBarItem(
            icon: const Icon(Icons.create),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.camera),
            label: 'Preview',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.sailing),
            label: 'Result',
          ),
        ],
      ),
    );
  }
}
