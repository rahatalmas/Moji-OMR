import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quizapp/constant.dart';

class ScholarCard extends StatelessWidget {
  final String scholarId;
  final String scholarName;
  final String? scholarPicture; // Nullable
  final String schoolName;
  final String classLevel;

  const ScholarCard({
    Key? key,
    required this.scholarId,
    required this.scholarName,
    this.scholarPicture,
    required this.schoolName,
    required this.classLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: neutralWhite,
      shadowColor: Colors.black87,
      elevation: 4,
      child: Slidable(
        key: Key(scholarId), // Provide a Key to prevent errors in lists
        endActionPane: ActionPane(
          motion: const ScrollMotion(), // For a right swipe motion (reverse direction)
          dismissible: null, // Disable dismiss action
          children: [
            // Edit Button
            SlidableAction(
              onPressed: (context) {
                // Handle edit action
                print("Edit button clicked for $scholarId");
              },
              backgroundColor: colorPrimary,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            // Delete Button
            SlidableAction(
              borderRadius: BorderRadius.only(
                  topRight:Radius.circular(12),
                  bottomRight:Radius.circular(12)
              ),
              onPressed: (context) {
                // Handle delete action
                print("Delete button clicked for $scholarId");
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture with Border
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueAccent.withOpacity(0.5),
                    width: 3,
                  ),
                  image: scholarPicture != null
                      ? DecorationImage(
                    image: NetworkImage(scholarPicture!),
                    fit: BoxFit.cover,
                  )
                      : const DecorationImage(
                    image: AssetImage('assets/images/man.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scholarName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'School: $schoolName',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Class Level: $classLevel',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
      
              //swipe icon
              Icon(Icons.arrow_back_ios_new_rounded,color: colorPrimary,size: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
