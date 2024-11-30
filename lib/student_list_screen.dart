import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_database_2/add_student_screen.dart';
import 'package:student_database_2/student.dart';
import 'database_helper.dart';
import 'package:student_database_2/update_student_screen.dart';

List<Student> studentList = [];
late DatabaseHelper dbHelper;
refreshStudentList() async {
  studentList = await dbHelper.getAllStudents();
}

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    refreshStudentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Records")),
      body: studentList.isEmpty
          ? Center(child: Text('No students available. Add new students.'))
          : ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                final student = studentList[index];
                return Card(
                  child: ListTile(
                    leading: student.imagePath == null
                        ? CircleAvatar(child: Icon(Icons.person))
                        : CircleAvatar(
                            backgroundImage:
                                FileImage(File(student.imagePath!)),
                          ),
                    title: Text(student.name),
                    subtitle:
                        Text("Age: ${student.age}, Course: ${student.course}"),
                    trailing: SizedBox(
                      height: 30,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) {
                                    return UpdateStudentScreen(
                                        student: student);
                                  },
                                ),
                              );
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              dbHelper.deleteStudent(student.id!);
                              refreshStudentList();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  AddStudentScreen(onSave: refreshStudentList)),
        ),
      ),
    );
  }
}
