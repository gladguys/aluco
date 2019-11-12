import 'package:aluco/model/student.dart';

class StudentGrade {
  int examId;
  int studentId;
  String studentName;
  double grade;

  StudentGrade({this.examId, this.studentId, this.studentName, this.grade});

  StudentGrade.fromJson(Map<String, dynamic> json) {
    examId = json['examId'];
    studentId = json['studentId'];
    studentName = json['studentName'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['examId'] = examId;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['grade'] = grade;
    return data;
  }

  factory StudentGrade.fromStudentAndExam(Student student, int idExam) {
    return StudentGrade()
      ..studentId = student.id
      ..studentName = student.name
      ..examId = idExam;
  }

  @override
  String toString() {
    return 'StudentGrade{examId: $examId, studentId: $studentId, studentName: $studentName, grade: $grade}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StudentGrade &&
              runtimeType == other.runtimeType &&
              studentId == other.studentId;

  @override
  int get hashCode => studentId.hashCode;
}