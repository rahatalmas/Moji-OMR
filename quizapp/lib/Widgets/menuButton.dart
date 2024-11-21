import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';  // Replace with your actual constants

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Menu Button Example')),
        body: Center(
          child: MenuButton(
            title: 'Home',
            image: 'assets/home_icon.png', // Replace with your image path
            onTap: () {
              print('Menu button tapped!');
            },
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  final String title;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
            color: kColorPrimary
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 50,
                  width: 50,
                ),
                SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: appText, // Your text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
