import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_database_2/database_helper.dart';
import 'package:student_database_2/student.dart';

class AddStudentScreen extends StatefulWidget {
  final Function onSave;
  AddStudentScreen({required this.onSave});

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _courseController = TextEditingController();
  final _collegeNameController = TextEditingController();
  String? _imagePath;

  _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      Student newStudent = Student(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        course: _courseController.text,
        collegename: _collegeNameController.text,
        imagePath: _imagePath,
      );
      await DatabaseHelper.instance.insertStudent(newStudent);
      widget.onSave();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Student")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) => value!.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter age' : null,
                ),
                TextFormField(
                  controller: _courseController,
                  decoration: const InputDecoration(labelText: "Course"),
                  validator: (value) => value!.isEmpty ? 'Enter course' : null,
                ),
                TextFormField(
                  controller: _collegeNameController,
                  decoration: const InputDecoration(labelText: "College Name"),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter College Name' : null,
                ),
                const SizedBox(height: 10),
                _imagePath == null
                    ? Container(
                        height: 80,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black), // Black border
                        ),
                        child: const Text("No image selected"))
                    : Image.file(File(_imagePath!), height: 100),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text("Pick Profile Image"),
                ),
                ElevatedButton(
                  onPressed: _saveStudent,
                  child: const Text("Save Student"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
