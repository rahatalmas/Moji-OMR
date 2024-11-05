import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  final Function(int) updateComponent;
  const CreatePage({super.key, required this.updateComponent});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
               color: Colors.red[200],
               borderRadius: const BorderRadius.all(Radius.circular(15))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/leading2.png",width: 50,),
                    Text("Enter the name of Examination",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                  ],
                ),
                const SizedBox(height: 5,),
                TextField(
                  decoration: InputDecoration(
                    labelText: "type here...",
                    hintText: "O Level Final",
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Padding(padding:EdgeInsets.only(left: 15,right: 5),child: Icon(Icons.terminal_sharp, size: 30, color: Colors.brown[800]),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black, width: 3.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black, width: 3.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.black, width: 3.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.red, width: 3.5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.red, width: 3.5),
                    ),
                    fillColor: Colors.white, // Set the background color to white
                    filled: true, // Make sure the background color is applied
                  ),
                )
              ],
            ),

          ),
          SizedBox(height: 10,),
          Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.teal[900],
                  borderRadius: const BorderRadius.all(Radius.circular(15))
              ), // Add some padding for better tap area
              child: Column(
                children: [
                  Text("Create Question",style: TextStyle(color: Colors.white,fontSize: 25,letterSpacing: 1,fontWeight:FontWeight.bold),),
                  Text("Type and Go",style: TextStyle(color: Colors.white,fontSize: 15,letterSpacing: 1,fontWeight:FontWeight.bold),),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      updateComponent(1);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                      decoration: BoxDecoration(
                         color: Colors.teal,
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.black,width: 3.5)

                       ),
                      child: Text("Editor",style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing: 1,fontWeight:FontWeight.bold),),

                    ),
                  )
                ],
              ),
            ),
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.teal[900],
                borderRadius: const BorderRadius.all(Radius.circular(15))
            ), // Add some padding for better tap area
            child: Column(
              children: [
                Text("Create OMR SHEET",style: TextStyle(color: Colors.white,fontSize: 25,letterSpacing: 1,fontWeight:FontWeight.bold),),
                Text("Set and Go",style: TextStyle(color: Colors.white,fontSize: 15,letterSpacing: 1,fontWeight:FontWeight.bold),),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    updateComponent(2);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.black,width: 3.5)

                    ),
                    child: Text("Generator",style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 1,fontWeight:FontWeight.bold),),

                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: const BorderRadius.all(Radius.circular(15))
            ), // Add some padding for better tap area
            child: Column(
              children: [
                Text("Justify Answer",style: TextStyle(color: Colors.white,fontSize: 25,letterSpacing: 1,fontWeight:FontWeight.bold),),
                Text("Upload and get",style: TextStyle(color: Colors.white,fontSize: 15,letterSpacing: 1,fontWeight:FontWeight.bold),),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.black,width: 3.5)

                    ),
                    child: Text("Tester",style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing: 1,fontWeight:FontWeight.bold),),

                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

