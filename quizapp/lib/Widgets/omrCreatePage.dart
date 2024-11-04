import 'package:flutter/material.dart';

class OmrCreatePage extends StatefulWidget{
  const OmrCreatePage({super.key});
  @override
  State<OmrCreatePage> createState ()=> _OmrCreatePage();
}

class _OmrCreatePage extends State<OmrCreatePage>{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("OMR CREATOR")
        ],
      ),
    );
  }
}