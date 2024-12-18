import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import '../../providers/candidateProvider.dart';

class CandidatePreviewScreen extends StatelessWidget {
  const CandidatePreviewScreen({super.key});

  // Function to show the modal with options
  void _showOptionsModal(BuildContext context, int index){
    final candidateProvider = Provider.of<CandidateProvider>(context,listen:false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  // Add your edit functionality here
                  print('Edit candidate: ${index}');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove'),
                onTap: () async  {
                  int examId = candidateProvider.candidates[index].examId;
                  bool res = await candidateProvider.deleteCandidate(
                      candidateProvider.candidates[index].serialNumber,
                      examId
                  );
                  if(res){
                    await candidateProvider.getAllCandidates(examId);
                  }
                  Navigator.pop(context);
                  // Add your remove functionality here
                  print('Remove candidate: ${index}');
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);  // Close the modal
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final candidateProvider = Provider.of<CandidateProvider>(context,listen: true);
    return  ListView(
      children: [
        candidateProvider.candidates.isEmpty
            ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
                Image.asset("assets/images/man.png",height: 200,width: 200,),
                SizedBox(height: 20,),
                Text("No Candidate Registered yet")
              ],
            )
            :
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: candidateProvider.candidates.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 2),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: neutralWhite,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 1,spreadRadius: 1)]
                  ),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset("assets/images/man.png",
                                  width: 116,
                                  height: 116,
                                  fit: BoxFit.cover,
                                )
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Serial: ${candidateProvider.candidates[index].serialNumber}',
                                        style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: (){
                                            //open a modal with options edit, remove, cancel
                                            _showOptionsModal(context, index);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 16),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 5,
                                                width: 5,
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                              SizedBox(height: 2,),
                                              Container(
                                                height: 5,
                                                width: 5,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                              SizedBox(height: 2,),
                                              Container(
                                                height: 5,
                                                width: 5,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Name: ${candidateProvider.candidates[index].name}',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                    'Scholar Id: ${candidateProvider.candidates[index].scholarId}',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                    'Level: ${candidateProvider.candidates[index].classLevel}',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  Text(
                                    'Institute: ${candidateProvider.candidates[index].schoolName}',
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8,),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
