import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/exam/examCreatePage.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/examProvider.dart';

class ResultDetailsScreen extends StatefulWidget {
  @override
  _ResultDetailsScreen createState() => _ResultDetailsScreen();
}

class _ResultDetailsScreen extends State<ResultDetailsScreen> {
  late ExamProvider _examProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _examProvider = context.watch<ExamProvider>();
    if (!_examProvider.dataUpdated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _examProvider.getAllExams();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results Details'),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
        actions: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExamCreatePage()),
            ),
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      backgroundColor: neutralWhite,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: brandMinus3,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text("Operation System",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: colorPrimary),)),
                      InkWell(
                          onTap: () {
                            print("info");
                          },
                          child: const Icon(
                            Icons.new_releases_outlined,
                            size: 24,
                            color: colorPrimary,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.supervisor_account,size: 20,color: colorPrimary,),
                          Text("Total Student: 100"),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Icon(Icons.fact_check_outlined,size: 20,color: colorPrimary,),
                          Text("Checked: 50"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 2,),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Passed: 50"),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 8,
                              backgroundColor:
                              Colors.redAccent,
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Fail: 0"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 4,),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [Icon(Icons.list), Text("Results")],
                ),
                Row(
                  children: [Text("filter"),Icon(Icons.arrow_drop_down_outlined,size: 24,),],
                ),

              ],
            ),
            SizedBox(height: 4,),
            Expanded(
              child: ListView.builder(
                itemCount: _examProvider.exams.length,
                itemBuilder: (context, index) {
                  final exam = _examProvider.exams[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 2,
                    ),
                    decoration: BoxDecoration(
                      color: neutralWhite,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: InkWell(
                        onTap: () {
                          print("Student Result Card");
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Image.asset("assets/images/man.png",width: 90,),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text("Rahat Almas",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  overflow: TextOverflow.ellipsis
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4,),
                                          Row(
                                            children: [
                                              Text("Passed",style: TextStyle(color: Colors.green),),
                                              Icon(Icons.radio_button_checked,color: Colors.green,size: 18,),
                                            ],
                                          )
                                        ],
                                      ),
                                      Text("Serial Number: 1001"),
                                      Row(
                                        children: [
                                          Text("Mark: 45"),
                                          SizedBox(width: 8,),
                                          Text("Out of: 50")
                                        ],
                                      ),
                                      Text("Grade: A+",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),)
                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {},
              child: Ink(
                width: double.maxFinite,
                height: 48,
                decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(12)),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Download PDF",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}
