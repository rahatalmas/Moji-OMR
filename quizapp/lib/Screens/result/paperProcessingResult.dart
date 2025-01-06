import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/result/resultScreen.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/scholarProvider.dart';

class PaperProcessingResult extends StatelessWidget {

  PaperProcessingResult(
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    final scholarProvider = Provider.of<ScholarProvider>(context,listen:true);
    final examProvider = Provider.of<ExamProvider>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Paper Processing Output",
          style: TextStyle(color: appTextPrimary),
        ),
        centerTitle: true,
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: appTextPrimary),
        elevation: 3,
        shadowColor: Colors.grey,
        actions: [
          InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultScreen()),
              ),
              child: Icon(Icons.add)),
          SizedBox(width: 16),
        ],
      ),
      backgroundColor: neutralWhite,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // success container
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
              decoration: BoxDecoration(
                color: brandMinus3,
                borderRadius: BorderRadius.circular(8),
                //border: Border.all(color: brandP,width: 2.5)
              ),
              child: Column(
                children: [
                  Lottie.asset("assets/images/success1.json",width: 112),
                  Text('Checking Successful',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: colorPrimary),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Requested: ${10}',style: TextStyle(color: colorPrimary)),
                      SizedBox(width: 4,),
                      Text('Valid: ${5}',style: TextStyle(color: colorPrimary)),
                      SizedBox(width: 4,),
                      Text('Invalid: ${5}',style: TextStyle(color: colorPrimary)),
                    ],
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("Done",style: TextStyle(color: neutralWhite,fontWeight: FontWeight.w500),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8,),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.list,size: 21,),
                    Text("Output List")
                  ],
                ),
                Row(
                  children: [
                    Text("Filter"),
                    Icon(Icons.filter_vintage_rounded,size: 18,),
                  ],
                )
              ],
            ),
            SizedBox(height: 4,),
            Expanded(
                child: ListView.builder(
                  itemCount:10,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 2.5),
                          padding:EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: neutralWhite,
                              boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2,spreadRadius: 1)],
                              borderRadius: BorderRadius.circular(6)
                          ),

                          child:  index>=5
                              ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  //Image.asset("assets/images/man.png",width: 50,),
                                  SizedBox(width: 4,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Serial Number: ${'1001'}'),
                                      Row(
                                        children: [
                                          Text('Result Already Exist'),
                                          SizedBox(width: 8,),
                                          //Text('Out Of: ${'40'}'),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: index<5
                                    ?
                                Column(
                                  children: [
                                    Icon(Icons.cloud_done,color: Colors.green,),
                                    Text("saved",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.green),)
                                  ],
                                )
                                    :
                                Column(
                                  children: [
                                    Icon(Icons.cancel_rounded,color: Colors.red,),
                                    Text("Canceled",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.red),)
                                  ],
                                )
                                ,
                              ),
                            ],
                          )
                              :
                          //Card for candidates result
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/man.png",width: 50,),
                                  SizedBox(width: 4,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Serial Number: ${'1001'}'),
                                      Row(
                                        children: [
                                          Text('Correct: ${'35'}'),
                                          SizedBox(width: 8,),
                                          Text('Out Of: ${'40'}'),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: index<5
                                    ?
                                Column(
                                  children: [
                                    Icon(Icons.cloud_done,color: Colors.green,),
                                    Text("saved",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.green),)
                                  ],
                                )
                                    :
                                Column(
                                  children: [
                                    Icon(Icons.cancel_rounded,color: Colors.red,),
                                    Text("Canceled",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.red),)
                                  ],
                                )
                                ,
                              ),
                            ],
                          ),
                        ),
                        if (index == 5 - 1) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.cancel_schedule_send,size: 16,
                              ),
                              SizedBox(width: 8,),
                              Text("Invalid Papers"),
                              SizedBox(width: 8,),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 2,
                                    color: brandMinus3,
                                  )
                              ),
                            ],
                          ),
                        ]
                      ],
                    );
                  },
                )),
            SizedBox(height: 8,),
            InkWell(
              onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>ResultScreen())
                     );
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Home",style: TextStyle(color: neutralWhite,fontWeight: FontWeight.w500),),
              ),
            )
          ],
        ),
      ), // Display the selected widget
    );
  }
}
