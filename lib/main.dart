import 'package:flutter/material.dart';
import 'package:student_database_2/flash_screen.dart';

import 'student_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Database',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Flash_Screen()
      //  StudentListScreen(),
    );
  }
}
