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
          Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.green[300],
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.panorama_fish_eye),
                    Text("OMR Sheet Creator")
                  ],
                ),
                Row(
                  children: [
                    Text("Edit"),
                    Icon(Icons.settings)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
