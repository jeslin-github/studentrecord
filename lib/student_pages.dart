import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_database_2/student.dart';

class StudentPage extends StatelessWidget {
  final Student student;

  const StudentPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(File(student.imagePath!)),
                    fit: BoxFit.cover),
              ),
            )),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9F8F6),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      student.name,
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text((student.age).toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300)),
                    Text(
                      student.course,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    Text(student.collegename,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300)),
                    Container(
                      alignment: Alignment.center,
                      width: 250,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFEA00),
                          borderRadius: BorderRadius.circular(50)),
                      margin: const EdgeInsets.all(20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "exit",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
