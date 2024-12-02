import 'package:flutter/material.dart';
import 'package:quizapp/Screens/admin/adminAddScreen.dart';
import 'package:quizapp/constant.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, String>> adminList = [
    {"name": "Hatake Kakashi", "role": "Admin"},
    {"name": "Haruno Sakura", "role": "Editor"},
    {"name": "Uchiha Sasuke", "role": "Moderator"},
    {"name": "Nara Shikamaru", "role": "Admin"},
    {"name": "Rock Lee", "role": "Admin"},
  ];

  // Profile owner data
  String profileOwnerName = "Uzumaki Naruto";
  String profileOwnerRole = "Admin";

  // Selected filter
  String selectedFilter = "All";

  // Method to show the add new user dialog
  void showAddNewUserDialog() {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController roleController = TextEditingController();
    bool isValid = false;

    // Validate the inputs
    void validateInputs() {
      setState(() {
        isValid = usernameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            roleController.text.isNotEmpty;
      });
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Add New User"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: usernameController,
                  onChanged: (value) {
                    setDialogState(validateInputs);
                  },
                  decoration: const InputDecoration(labelText: "Username"),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  onChanged: (value) {
                    setDialogState(validateInputs);
                  },
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                TextField(
                  controller: roleController,
                  onChanged: (value) {
                    setDialogState(validateInputs);
                  },
                  decoration: const InputDecoration(labelText: "Role"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: isValid
                    ? () {
                  setState(() {
                    adminList.add({
                      "name": usernameController.text,
                      "role": roleController.text,
                    });
                  });
                  Navigator.pop(context); // Close the dialog
                }
                    : null, // Disable the button if inputs are invalid
                child: const Text("Add"),
              ),
            ],
          );
        },
      ),
    );
  }

  // Method to show the filter bottom sheet
  void showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                title: const Text("All"),
                onTap: () {
                  setState(() {
                    selectedFilter = "All";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Admin"),
                onTap: () {
                  setState(() {
                    selectedFilter = "Admin";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Editor"),
                onTap: () {
                  setState(() {
                    selectedFilter = "Editor";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Moderator"),
                onTap: () {
                  setState(() {
                    selectedFilter = "Moderator";
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

  // Method to show the edit user dialog
  void showEditUserDialog(int index) {
    final TextEditingController usernameController =
    TextEditingController(text: adminList[index]['name']);
    final TextEditingController roleController =
    TextEditingController(text: adminList[index]['role']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                adminList[index] = {
                  "name": usernameController.text,
                  "role": roleController.text,
                };
              });
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filtered list based on selected filter
    final filteredList = selectedFilter == "All"
        ? adminList
        : adminList.where((admin) => admin["role"] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: AppBar(
        title: Text("admin"),
        backgroundColor: neutralWhite,
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Owner Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: neutralBG,
                  borderRadius: BorderRadius.circular(15),
                  //border: Border.all(color:kColorPrimary, width: 3),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: Image.asset("assets/images/man2.png"),
                          radius: 35,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    profileOwnerName,
                                    style: TextStyle(
                                      color: Colors.brown[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => showEditUserDialog(0), // Edit profile
                                    child: Row(
                                      children: [
                                        Text(
                                          "edit",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(Icons.edit_note,color: Colors.black87,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Role: $profileOwnerRole",
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminAddScreen()),
                                ), // Add New User
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colorPrimary,
                                    //border: Border.all(color: Colors.indigo, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text("Add New",style: TextStyle(color: Colors.white),),
                                      Icon(Icons.new_label_outlined,color: Colors.white,),
                                    ],
                                  ),
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
              const SizedBox(height: 10),
              // Admin List Header
              GestureDetector(
                onTap: showFilterBottomSheet, // Open filter bottom sheet
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text("Admin List"),
                        SizedBox(width: 5),
                        Icon(Icons.list),
                      ],
                    ),
                    Row(
                      children: const [
                        Text("Filter"),
                        SizedBox(width: 2),
                        Icon(Icons.filter_alt_outlined),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Admin List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final admin = filteredList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: neutralWhite,
                      borderRadius: BorderRadius.circular(12),
                      //border: Border.all(color: Colors.deepPurple, width: 1),
                      boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 1)]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/images/man.png"),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                admin['name']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown[800],
                                ),
                              ),
                              Text(
                                "Role: ${admin['role']}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (profileOwnerRole == "Admin")
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => showEditUserDialog(index), // Edit
                                icon: const Icon(Icons.edit, color: colorPrimary),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    adminList.removeAt(index); // Delete
                                  });
                                },
                                icon:  Icon(Icons.delete, color: Colors.red[900]),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
