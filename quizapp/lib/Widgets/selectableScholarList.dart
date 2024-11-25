import 'package:flutter/material.dart';
import 'package:quizapp/Screens/scholar/dummyScholarList.dart';
import 'package:quizapp/Screens/scholar/selectableScholarCard.dart';
import 'package:quizapp/constant.dart';

class ScholarList2 extends StatefulWidget {
  final List<Scholar> scholars;

  const ScholarList2({Key? key, required this.scholars}) : super(key: key);

  @override
  _ScholarList2State createState() => _ScholarList2State();
}

class _ScholarList2State extends State<ScholarList2> {
  final Set<String> _markedScholars = {}; // To store selected scholar IDs
  List<String> selectedSchools = [];
  String? selectedSortOption;
  bool isAscending = true;

  void toggleSchoolSelection(String school) {
    setState(() {
      if (selectedSchools.contains(school)) {
        selectedSchools.remove(school);
      } else {
        selectedSchools.add(school);
      }
    });
  }

  void sortScholars() {
    setState(() {
      scholars.sort((a, b) {
        int comparison = 0;

        // Sorting based on selected option
        if (selectedSortOption == 'Name') {
          comparison = a.scholarName.compareTo(b.scholarName);
        } else if (selectedSortOption == 'School') {
          comparison = a.schoolName.compareTo(b.schoolName);
        } else if (selectedSortOption == 'Class Level') {
          comparison = a.classLevel.compareTo(b.classLevel);
        }

        // Ascending or Descending sorting
        if (!isAscending) {
          comparison = -comparison;
        }

        return comparison;
      });
    });
  }

  // Filtered scholars based on selected schools
  List<Scholar> get filteredScholars {
    if (selectedSchools.isEmpty) {
      return scholars;
    } else {
      return scholars.where((scholar) => selectedSchools.contains(scholar.schoolName)).toList();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filters Row
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(width: 3),
                  Text("Scholar list")
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => showSchoolFilterDialog(context),
                    child: Row(
                      children: [
                        Text("School"),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => showSortOptionsDialog(context),
                    child: Row(
                      children: [
                        Text("Sort"),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredScholars.length,
          itemBuilder: (context, index) {
            final scholar = filteredScholars[index];
            final isMarked = _markedScholars.contains(scholar.scholarId);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isMarked) {
                    _markedScholars.remove(scholar.scholarId);
                  } else {
                    _markedScholars.add(scholar.scholarId);
                  }
                });
              },
              child: SelectableScholarCard(
                scholarId: scholar.scholarId,
                scholarName: scholar.scholarName,
                scholarPicture: scholar.scholarPicture,
                schoolName: scholar.schoolName,
                classLevel: scholar.classLevel,
                isMarked: isMarked,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: (){
            print(_markedScholars);
          },
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
                  "Save",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(width: 3,),
                Icon(Icons.save_as, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // School filter dialog
  void showSchoolFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                ...scholars.map((scholar) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          toggleSchoolSelection(scholar.schoolName);
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectedSchools.contains(scholar.schoolName),
                            onChanged: (bool? value) {
                              setState(() {
                                toggleSchoolSelection(scholar.schoolName);
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(scholar.schoolName),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                // Done Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text("Done"),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }


  // Sort options dialog
  void showSortOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                ListTile(
                  title: Text("Sort by Name"),
                  onTap: () {
                    setState(() {
                      selectedSortOption = 'Name';
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Sort by School"),
                  onTap: () {
                    setState(() {
                      selectedSortOption = 'School';
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Sort by Class Level"),
                  onTap: () {
                    setState(() {
                      selectedSortOption = 'Class Level';
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Ascending"),
                  onTap: () {
                    setState(() {
                      isAscending = true;
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Descending"),
                  onTap: () {
                    setState(() {
                      isAscending = false;
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

}


