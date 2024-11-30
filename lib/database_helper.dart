import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_database_2/student.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('student.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER ,
        course TEXT,
        collegename TEXT,
        imagePath TEXT
      )
    ''');
  }

  Future<int> insertStudent(Student student) async {
    Database db = await instance.database;
    return await db.insert('students', student.toMap());
  }

  Future<List<Student>> getAllStudents() async {
    Database db = await instance.database;
    final result = await db.query('students');
    return result.map((map) => Student.fromMap(map)).toList();
  }

  Future<int> deleteStudent(int id) async {
    Database db = await instance.database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateStudentData(
      {required String name,
      required int age,
      required String course,
      required String collegename,
      required String image,
      required int id}) async {
    Database db = await instance.database;
    print('update student called $name $age $course $collegename $image $id');
    await db.rawUpdate(
        'UPDATE students SET name = ?, age = ?, course = ?, collegename = ?, imagePath = ? WHERE id = ?',
        [name, age, course, collegename, image, id]);
    await getAllStudents();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
