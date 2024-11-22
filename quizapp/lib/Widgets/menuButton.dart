import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizapp/constant.dart';  // Replace with your actual constants


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
            color: neutralBG,
        boxShadow: [BoxShadow(color:Colors.black26,blurRadius: 0.3,spreadRadius: 0.3)],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  image,
                  height: 50,
                  width: 50,
                ),
                SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
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
