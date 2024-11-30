class Student {
  int? id;
  String name;
  int age;
  String course;
  String collegename;
  String? imagePath;

  Student(
      {this.id,
      required this.name,
      required this.age,
      required this.course,
      required this.collegename,
      this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'course': course,
      'collegename': collegename,
      'imagePath': imagePath,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      course: map['course'],
      collegename: map['collegename'],
      imagePath: map['imagePath'],
    );
  }
}
