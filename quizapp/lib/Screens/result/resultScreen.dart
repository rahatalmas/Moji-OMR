import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/exam/examCreatePage.dart';
import 'package:quizapp/Screens/result/resultDetails.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/examProvider.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreen createState() => _ResultScreen();
}

class _ResultScreen extends State<ResultScreen> {
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
        title: Text('Results'),
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
      body: _examProvider.isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/images/animation5.json",
                ),
                const Text("Fetching Data...")
              ],
            )
          : _examProvider.message.isNotEmpty
              ? Text(_examProvider.message)
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 4,),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [Icon(Icons.list), Text("List Exams")],
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
                                    print("Result Card");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context){
                                              return ResultDetailsScreen();
                                            }
                                        )
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                           const Expanded(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.open_in_new,
                                                    size: 16,
                                                    color: colorPrimary,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Operating System",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        color: colorPrimary
                                                      ),
                                                      //overflow: TextOverflow.clip,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
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
                              "Add Result",
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
