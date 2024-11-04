import 'package:flutter/material.dart';
import 'package:quizapp/Widgets/create.dart';

void main() {
  runApp(const MyApp());
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
  int _currentIndex = 0; // Current index for the bottom navigation

  final List<Widget> _children = [
    const Create(),
    const Center(child: Text("Result")),
    const Center(child: Text("Dashboard")),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update current index
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
        backgroundColor: Colors.deepOrange[200],
        title: Text(widget.title),
        leading:Image.asset("assets/images/leading2.png"),
        actions: const [
          Icon(Icons.content_paste_search),
          SizedBox(width: 10,),
          Icon(Icons.mode_night),
          SizedBox(width: 15,)
        ],
      ),
      body: Padding(
          padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          child: _children[_currentIndex],
      ), // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.deepOrange[200],// Current selected index
        onTap: onTabTapped, // Callback for tab change
        items:const [
          BottomNavigationBarItem(
            icon: const Icon(Icons.create),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.camera),
            label: 'Result',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
