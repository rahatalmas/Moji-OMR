import 'package:quizapp/Screens/scholar/scholarScreen.dart';
class Scholar {
  final String scholarId;
  final String scholarName;
  final String? scholarPicture;
  final String schoolName;
  final String classLevel;

  Scholar({
    required this.scholarId,
    required this.scholarName,
    this.scholarPicture,
    required this.schoolName,
    required this.classLevel,
  });
}

List<Scholar> scholars = [
  Scholar(
    scholarId: '1',
    scholarName: 'Alice Johnson',
    scholarPicture: null,
    schoolName: 'Greenwood High',
    classLevel: 'Grade 10',
  ),
  Scholar(
    scholarId: '2',
    scholarName: 'Bob Smith',
    scholarPicture: null,
    schoolName: 'Sunrise Academy',
    classLevel: 'Grade 12',
  ),
  Scholar(
    scholarId: '3',
    scholarName: 'Charlie Brown',
    scholarPicture: null,
    schoolName: 'Sujanar Model Pilot High School Pabna',
    classLevel: 'Grade 9',
  ),
];