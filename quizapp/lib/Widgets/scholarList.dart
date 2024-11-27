import 'package:flutter/material.dart';
import 'package:quizapp/Screens/scholar/dummyScholarList.dart';
import 'package:quizapp/Screens/scholar/scholarCard.dart';

class ScholarList extends StatefulWidget {
  final List<Scholar> scholars;

  const ScholarList({Key? key, required this.scholars}) : super(key: key);

  @override
  _ScholarListState createState() => _ScholarListState();
}

class _ScholarListState extends State<ScholarList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.scholars.length,
      itemBuilder: (context, index) {
        final scholar = widget.scholars[index];
        return ScholarCard(
          scholarId: scholar.scholarId,
          scholarName: scholar.scholarName,
          scholarPicture: scholar.scholarPicture,
          schoolName: scholar.schoolName,
          classLevel: scholar.classLevel,
        );
      },
    );
  }
}
