import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';

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
    return Expanded(
        child:  InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: kColorSecondary,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 1)]
            ), // Add some padding for better tap area
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image,height: 50,width: 50,),
                SizedBox(height: 3,),
                Text(title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: kColorPrimary),),
              ],
            ),
          ),
        ),
    );
  }
}
