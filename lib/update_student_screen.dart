import 'package:flutter/material.dart';

import 'package:student_database_2/database_helper.dart';
import 'package:student_database_2/student.dart';

class UpdateStudentScreen extends StatefulWidget {
  // final Function onSave;
  final Student student;

  UpdateStudentScreen({required this.student});

  @override
  _UpdateStudentScreenState createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  // final _formKey = GlobalKey<FormState>();
  // final _nameController = TextEditingController();
  // final _ageController = TextEditingController();
  // final _courseController = TextEditingController();
  // final _collegeNameController = TextEditingController();
  // String? _imagePath;

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController courseController;
  late TextEditingController collegenameController;//! whats going on ?????????????????????????????????????????????????????????????
  late String imagepath;
  late int id;
  late DatabaseHelper _dbHelper;
  // late StudentListScreen _listinstance;
  final _formKey = GlobalKey<FormState>();
  // _pickImage() async {

  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       nameController = TextEditingController(text: widget.student.name);
  //       ageController = TextEditingController(text: widget.student.age.toString());
  //       courseController = TextEditingController(text: widget.student.course);
  //       collegenameController = TextEditingController(text: widget.student.collegename);

  //     });
  //   }
  // }

  // _saveStudent() async {
  //   if (_formKey.currentState!.validate()) {
  //     await DatabaseHelper.instance.insertStudent(newStudent);

  //     Navigator.of(context).pop();
  //   }
  // }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
    courseController = TextEditingController(text: widget.student.course);
    collegenameController =
        TextEditingController(text: widget.student.collegename);
    imagepath = widget.student.imagePath!;
    id = widget.student.id!;
    _dbHelper = DatabaseHelper.instance;
    // _listinstance = StudentListScreen();
    super.initState();
  }

  // refreshStudentListnew() async {
  //   // studentList = await _dbHelper.getAllStudents();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Student")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) => value!.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter age' : null,
                ),
                TextFormField(
                  controller: courseController,
                  decoration: const InputDecoration(labelText: "Course"),
                  validator: (value) => value!.isEmpty ? 'Enter course' : null,
                ),
                TextFormField(
                  controller: collegenameController,
                  decoration: const InputDecoration(labelText: "College Name"),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter College Name' : null,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _updateStudent,
                  // onPressed: () {
                  //   print('onpressed update student called');
                  //   _updateStudent;
                  // },
                  child: const Text("Save Student"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateStudent() async {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final age = int.parse(ageController.text);
      final course = courseController.text;
      final collegename = collegenameController.text;
      final image = imagepath;
      final _id = id;

      print('_update fn called from student screen');

      _dbHelper.updateStudentData(
          name: name,
          age: age,
          course: course,
          collegename: collegename,
          image: image,
          id: _id);
      // refreshStudentListnew;

      // _listinstance.refreshStudentList();

      Navigator.of(context).pop();
    }
  }
}
