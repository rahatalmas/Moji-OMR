import 'package:flutter/material.dart';
import 'package:quizapp/Screens/scholar/dummyScholarList.dart';
import 'package:quizapp/Screens/scholar/scholarCard.dart';
import 'package:quizapp/Widgets/scholarList.dart';
import 'package:quizapp/Widgets/selectableScholarList.dart';
import 'package:quizapp/constant.dart';

class ScholarScreen extends StatefulWidget {
  const ScholarScreen({Key? key}) : super(key: key);

  @override
  _ScholarScreenState createState() => _ScholarScreenState();
}

class _ScholarScreenState extends State<ScholarScreen> {


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
    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: AppBar(
        title: Text('Scholars'),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
        actions: [
          Icon(Icons.add),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
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

            // Scholar List
            ScholarList(scholars: filteredScholars),
            //ScholarList2(scholars: filteredScholars)
          ],
        ),
      ),
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

