import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/scholar.dart';
import 'package:quizapp/providers/scholarProvider.dart';

class ScholarAddScreen extends StatefulWidget {
  const ScholarAddScreen({super.key});

  @override
  State<ScholarAddScreen> createState() => _ScholarAddScreenState();
}

class _ScholarAddScreenState extends State<ScholarAddScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _classLevelController = TextEditingController();

  File? _selectedImage; // Holds the selected image file

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 15, right: 5),
      child: Icon(Icons.input, size: 30, color: kColorPrimary),
    ),
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

  Future<void> _uploadPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _schoolNameController.dispose();
    _classLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scholarProvider = Provider.of<ScholarProvider>(context,listen: false);
    final bool isKeyboardVisible =
    KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Scholar",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: neutralWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 16),
                // Scholar Picture Upload
                GestureDetector(
                  onTap: _uploadPicture,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                      border: Border.all(color: kColorPrimary, width: 2),
                      image: _selectedImage != null
                          ? DecorationImage(
                        image: FileImage(_selectedImage!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: _selectedImage == null
                        ? const Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: kColorPrimary,
                    )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),

                // Full Name Field
                TextField(
                  controller: _fullNameController,
                  decoration: _textFieldDecoration.copyWith(
                    labelText: "Full Name",
                    hintText: "Enter scholar's full name",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10),

                // School Name Field
                TextField(
                  controller: _schoolNameController,
                  decoration: _textFieldDecoration.copyWith(
                    labelText: "School Name",
                    hintText: "Enter school name",
                    prefixIcon: const Icon(Icons.school),
                  ),
                ),
                const SizedBox(height: 10),

                // Class Level Field
                TextField(
                  controller: _classLevelController,
                  decoration: _textFieldDecoration.copyWith(
                    labelText: "Class Level",
                    hintText: "Enter class level (e.g., Grade 10)",
                    prefixIcon: const Icon(Icons.grade),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  Scholar newScholar = Scholar.forPost(
                      scholarName: _fullNameController.text,
                      scholarSchool: _schoolNameController.text,
                      classLevel: _classLevelController.text
                  );
                  bool res = await scholarProvider.addScholar(newScholar);
                  if(res){
                    await scholarProvider.getAllScholars();
                    print("new scholar added from screen add scholar ");
                  }else{
                    print("something went wrong");
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Save",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
