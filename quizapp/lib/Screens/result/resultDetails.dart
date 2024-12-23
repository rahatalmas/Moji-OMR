import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/exam/examCreatePage.dart';
import 'package:quizapp/constant.dart';
import '../../providers/resultProvider.dart';

class ResultDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> examResult;
  ResultDetailsScreen({super.key, required this.examResult});
  @override
  _ResultDetailsScreen createState() => _ResultDetailsScreen();
}

class _ResultDetailsScreen extends State<ResultDetailsScreen> {
  // late ResultProvider _resultProvider;
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _resultProvider = context.watch<ResultProvider>();
  //   if (!_resultProvider.dataUpdated) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _resultProvider.getAllResults();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> examResult = widget.examResult;
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
                      Expanded(child: Text(examResult['exam_name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: colorPrimary),)),
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
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.supervisor_account,size: 20,color: colorPrimary,),SizedBox(width: 2,),
                         Text(examResult['candidate_count'].toString()),
                        ],
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Icon(Icons.fact_check_outlined,size: 20,color: colorPrimary,),SizedBox(width: 2,),
                          Text('${examResult['candidates'].length}'),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 2,),
                  Row(
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
                          Text('Passed: ${examResult['candidates'].length-examResult['fail_count']}'),
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
                          Text('Fail: ${examResult['fail_count']}'),
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
                itemCount: examResult['candidates'].length,
                itemBuilder: (context, index) {
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
                                            child: Text(examResult['candidates'][index]['candidate_name'],
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
                                      Text('Serial: ${examResult['candidates'][index]['serial_number']}'),
                                      Row(
                                        children: [
                                          Text('Marks: ${examResult['candidates'][index]['correct_answers']}'),
                                          SizedBox(width: 8,),
                                          Text('Out Of: ${examResult['question_count']}')
                                        ],
                                      ),
                                      Text('Grade: ${examResult['candidates'][index]['grade']}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),)
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
