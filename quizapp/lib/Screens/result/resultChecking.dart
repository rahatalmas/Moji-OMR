import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/Screens/exam/dummyExamList.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'dart:io';

import 'package:quizapp/constant.dart';

import '../../database/models/exammodel.dart';

class ResultCheckScreen extends StatefulWidget {
  const ResultCheckScreen({super.key});

  @override
  State<ResultCheckScreen> createState() => _ResultCheckScreen();
}

class _ResultCheckScreen extends State<ResultCheckScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? selectedImages = [];

  Future<void> _pickImage() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    setState(() {
      selectedImages!.addAll(pickedFiles);
    });
  }
  Exam? _selectedExam;
  void _viewAllImages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageListScreen(
          images: selectedImages ?? [],
          onImageRemoved: (index) {
            setState(() {
              selectedImages!.removeAt(index);
            });
          },
        ),
      ),
    );
  }
  // for exam selection
  void _onExamSelected(Exam exam) {
    setState(() {
      _selectedExam = exam;
    });
  }

  @override
  Widget build(BuildContext context) {
    int imageCount = selectedImages?.length ?? 0;

    return ListView(
      children: [
        ExamFilterWidget(
          examList: examList,
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: brandMinus3,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: imageCount > 0
                      ? Image.file(
                    File(selectedImages![0].path),
                    fit: BoxFit.cover,
                  )
                      : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.filter),
                        Text("No Image Selected")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: _pickImage,
                    child: const Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            if (imageCount > 1)
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(selectedImages![1].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 2),
            if (imageCount > 2)
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(selectedImages![2].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 2),
            if (imageCount > 3)
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: _viewAllImages,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '+${imageCount - 3}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        selectedImages!.length > 0 ?
        InkWell(
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(8)
            ),
            alignment: Alignment.center,
            child: Text(
              "Check Papers",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          onTap: () {
            print('hello');
          },
        )
            :
            Center(
              child: Column(
                children: [
                  Lottie.asset("assets/images/animation3.json"),
                  Text("Select Answer papers")
                ],
              ),
            )
      ],
    );
  }
}


// all images
class ImageListScreen extends StatefulWidget {
  final List<XFile> images;
  final Function(int) onImageRemoved;

  const ImageListScreen({super.key, required this.images, required this.onImageRemoved});

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  late List<XFile> currentImages;

  @override
  void initState() {
    super.initState();
    currentImages = List.from(widget.images);
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        currentImages.addAll(pickedFiles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Images'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: currentImages.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.file(
                File(currentImages[index].path),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text('Image ${index + 1}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () {
                setState(() {
                  currentImages.removeAt(index); // Update the current list
                  widget.onImageRemoved(index); // Notify parent about removal
                });
              },
            ),
          );
        },
      ),
    );
  }
}
