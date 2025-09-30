import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/scholarProvider.dart';
import '../../providers/candidateProvider.dart';

class CandidatePreviewScreen extends StatelessWidget {
  const CandidatePreviewScreen({super.key});

  // Function to show the modal with options
  void _showOptionsModal(BuildContext context, int index) {
    final candidateProvider =
        Provider.of<CandidateProvider>(context, listen: false);
    final scholarProvider =
        Provider.of<ScholarProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove'),
                onTap: () async {
                  int examId = candidateProvider.candidates[index].examId;
                  bool res = await candidateProvider.deleteCandidate(
                    candidateProvider.candidates[index].serialNumber,
                    examId,
                  );
                  if (res) {
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    await candidateProvider.getAllCandidates(examId);
                    scholarProvider.getFilteredScholars(examId);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
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
    final candidateProvider =
        Provider.of<CandidateProvider>(context, listen: true);
    return candidateProvider.candidates.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/man.png",
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 25),
                const Text("No Candidate Registered yet"),
              ],
            ),
          )
        : candidateProvider.isLoading
            ? Center(
                child: Lottie.asset("assets/images/loader.json", width: 100))
            : ListView.builder(
                itemCount: candidateProvider.candidates.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 2),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: neutralWhite,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      "assets/images/man.png",
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          //open a modal with options edit, remove, cancel
                                          _showOptionsModal(context, index);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Serial: ${candidateProvider.candidates[index].serialNumber}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Icon(Icons.edit_note),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Name: ${candidateProvider.candidates[index].name}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'Scholar Id: ${candidateProvider.candidates[index].scholarId}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'Level: ${candidateProvider.candidates[index].classLevel}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        'Institute: ${candidateProvider.candidates[index].schoolName}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
  }
}
