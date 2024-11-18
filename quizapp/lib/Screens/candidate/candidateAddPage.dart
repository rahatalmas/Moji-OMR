import 'package:flutter/material.dart';
import 'package:quizapp/Screens/exam/dummyExamList.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/models/exammodel.dart';

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

  // Initialize input fields and candidate data
  void _onExamSelected(Exam exam) {
    setState(() {
      _selectedExam = exam;
      totalCandidates = exam.numberOfCandidates; // Set number of candidates based on selected exam
    });
  }

  // Method to add a candidate
  void _addCandidate() {
    final serialNumber = _serialNumberController.text;
    final candidateName = _candidateNameController.text;
    final schoolName = _schoolNameController.text;
    final classLevel = _classLevelController.text;

    if (serialNumber.isEmpty || candidateName.isEmpty || schoolName.isEmpty || classLevel.isEmpty) {
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
    prefixIcon: const Icon(Icons.input, size: 30, color: kColorPrimary),
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

  // Build text field with the provided label and controller
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: _textFieldDecoration.copyWith(
        labelText: label,
        hintText: "Enter $label",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          /*if (_selectedExam != null) ...[
            // Loop through the number of candidates and create input containers
            for (int i = 0; i < totalCandidates; i++) ...[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: kColorSecondary2,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Candidate - ${i + 1}",
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 5),
                    // Input fields for each candidate
                    _buildTextField("Serial Number", _serialNumberController),
                    const SizedBox(height: 10),
                    _buildTextField("Candidate Name", _candidateNameController),
                    const SizedBox(height: 10),
                    _buildTextField("School Name", _schoolNameController),
                    const SizedBox(height: 10),
                    _buildTextField("Class Level", _classLevelController),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: _addCandidate,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kColorPrimary,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Colors.black87, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Add Candidate",
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
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ]*/
          _selectedExam == null ? Center(child: Text("Noting selected"),):
          ListView.builder(
            itemCount: _selectedExam!.numberOfCandidates,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return  Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kColorSecondary2,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Candidate - ${index + 1}",
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 5),
                        // Input fields for each candidate
                        _buildTextField("Serial Number", _serialNumberController),
                        const SizedBox(height: 10),
                        _buildTextField("Candidate Name", _candidateNameController),
                        const SizedBox(height: 10),
                        _buildTextField("School Name", _schoolNameController),
                        const SizedBox(height: 10),
                        _buildTextField("Class Level", _classLevelController),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: _addCandidate,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: kColorPrimary,
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Colors.black87, width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Add Candidate",
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
                    ),
                  ),
                  const SizedBox(height: 15),

                ],
              );
            },
          )
        ],
      ),
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
