import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/Screens/exam/dummyExamList.dart';
import 'package:quizapp/Screens/scholar/dummyScholarList.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'package:quizapp/Widgets/selectableScholarList.dart';
import 'package:quizapp/constant.dart';

import '../../database/models/exammodel.dart';

class CandidateEditor extends StatefulWidget {
  const CandidateEditor({super.key});

  @override
  State<CandidateEditor> createState() => _CandidateEditor();
}

class _CandidateEditor extends State<CandidateEditor> {
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _candidateNameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _classLevelController = TextEditingController();

  int totalCandidates = 0; // Number of candidates (from selected exam)
  Exam? _selectedExam; // Store the selected exam
  int _selectedMode = 0; // Selected mode (default value)
  final List<String> _modes = ["Default Editing","Add from database","Upload File"];
  final List<Widget> _modeScreens = [

  ];

  // Initialize input fields and candidate data
  void _onExamSelected(Exam exam) {
    setState(() {
      _selectedExam = exam;
      totalCandidates = exam.numberOfCandidates; // Set number of candidates based on selected exam
    });
  }

  // Open bottom modal for mode selection
  void _showModeSelectionModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Mode",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Default Editing"),
                onTap: () {
                  setState(() {
                    _selectedMode = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.storage),
                title: const Text("Add from Database"),
                onTap: () {
                  setState(() {
                    _selectedMode = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text("Upload File"),
                onTap: () {
                  setState(() {
                    _selectedMode = 2;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to add a candidate
  void _addCandidate() {
    final serialNumber = _serialNumberController.text;
    final candidateName = _candidateNameController.text;
    final schoolName = _schoolNameController.text;
    final classLevel = _classLevelController.text;

    if (serialNumber.isEmpty ||
        candidateName.isEmpty ||
        schoolName.isEmpty ||
        classLevel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Clear the input fields after adding the candidate
    setState(() {
      _serialNumberController.clear();
      _candidateNameController.clear();
      _schoolNameController.clear();
      _classLevelController.clear();
    });
  }

  // Input field decoration (used for all fields)
  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: const Icon(Icons.input, size: 20, color: appTextPrimary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    fillColor: Colors.white,
    filled: true,
  );

  // Build text field with the provided label, controller, and icon
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: _textFieldDecoration.copyWith(
        labelText: label,
        hintText: "Enter $label",
        prefixIcon: Icon(icon, size: 20, color: appTextPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exam filter widget (to select exam)
            ExamFilterWidget(
              examList: examList,
              onExamSelected: (exam) {
                _onExamSelected(exam);
              },
            ),
            const SizedBox(height: 10),
            _selectedExam == null
                ? Center(
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Image.asset(
                    "assets/images/student.png",
                    height: 250,
                    width: 250,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Select an exam to add Candidate",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            )
                : Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: neutralBG
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mode and info
                  InkWell(
                    onTap: _showModeSelectionModal,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: const BoxDecoration(
                        border: BorderDirectional(
                          bottom: BorderSide(color: Colors.green, width: 5),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Colors.purple,
                                  ),
                                  const SizedBox(width: 4),
                                  const CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Colors.indigo,
                                  ),
                                  const SizedBox(width: 4,),
                                  const CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Colors.cyan,
                                  ),
                                  const SizedBox(width: 4,),
                                  Text(
                                    _modes[_selectedMode],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const Icon(Icons.edit_road)
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Candidate - ${146}",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "Total: ${300}",
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Remaining: ${155}",
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  //response from server
                  Container(
                    height: 150,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: neutralWhite,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Lottie.asset("assets/images/fileAdding.json",height: 110),
                          Text("Last Added: Almas")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),

                  // form fields
                  _selectedMode == 0
                      ?
                  Column(
                    children: [
                      _buildTextField(
                          "Serial Number", _serialNumberController, Icons.confirmation_number),
                      const SizedBox(height: 10),
                      _buildTextField("Candidate Name", _candidateNameController, Icons.person),
                      const SizedBox(height: 10),
                      _buildTextField("School Name", _schoolNameController, Icons.school),
                      const SizedBox(height: 10),
                      _buildTextField("Class Level", _classLevelController, Icons.grade),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: _addCandidate,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.black87, width: 2),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Icon(Icons.add, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                      :
                  ScholarList2(scholars: scholars)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _serialNumberController.dispose();
    _candidateNameController.dispose();
    _schoolNameController.dispose();
    _classLevelController.dispose();
    super.dispose();
  }
}

