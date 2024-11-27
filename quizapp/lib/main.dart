import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Widgets/QuestionTemplate.dart';
import 'package:quizapp/Widgets/createPage.dart';
import 'package:quizapp/Widgets/questionCreatePage.dart';
import 'package:quizapp/Widgets/omrCreatePage.dart';
import 'package:quizapp/providers/actionProvider.dart';
import 'package:quizapp/providers/questionProvider.dart';
import 'package:quizapp/routes.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moji OMR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return routes(routeSettings);
      },
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
  int _previousIndex = 0;
  late List<Widget> _components;
  late final List<Widget> _children;
  late bool editMode;

  @override
  void initState() {
    super.initState();
    _components = [
      CreatePage(updateComponent: updateComponent),
      const QuestionCreatePage(),
      const OmrCreatePage(),
    ];
    _children = [
      _components[0],
      const QuestionTemplate(),
      const Center(
        child: Text("Result Generator"),
      ),
    ];
  }

  void updateComponent(int index) {
    setState(() {
      _children[0] = _components[index];
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
      editMode =
          Provider.of<ActionStatusProvider>(context, listen: false).actionInfo;
      if (editMode == false) {
        updateComponent(0);
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      onTabTapped(_previousIndex);
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool editModeOn =
        Provider.of<ActionStatusProvider>(context, listen: true).actionInfo;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 5,
            shadowColor: Colors.black,
            //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Colors.yellow[200],
            title: Image.asset(
              "assets/images/logotemp2.png",
              width: 150,
            ),
            //title: Text("MOJI OMR"),
            //leading:Image.asset("assets/images/leading2.png"),
            actions: [
              Icon(Icons.content_paste_search),
              SizedBox(
                width: 10,
              ),
              editModeOn
                  ? InkWell(
                      child: Icon(Icons.sunny),
                      onTap: () {
                        Provider.of<ActionStatusProvider>(context,
                                listen: false)
                            .turnActionStatusOff();
                      })
                  : Icon(Icons.mode_night),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: _children[_currentIndex],
          ), // Display the selected screen
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.yellow[200],
            onTap: onTabTapped,
            items: const [
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
        ));
  }
}
