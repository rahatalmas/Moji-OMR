import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/candidateProvider.dart';

class CandidatePreviewScreen extends StatelessWidget {
  const CandidatePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final candidateProvider = Provider.of<CandidateProvider>(context,listen: false);
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Candidate Name: ${candidateProvider.candidates[index].name}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
