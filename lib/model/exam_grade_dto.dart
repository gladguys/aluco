import 'student.dart';

class ExamGradeDTO {
  int examId;
  int studentId;
  String studentName;
  double grade;

  ExamGradeDTO({this.examId, this.studentId, this.studentName, this.grade});

  ExamGradeDTO.fromStudent(Student student, int examId) {
    examId = examId;
    studentId = student.id;
    studentName = student.name;
    grade = null;
  }

  ExamGradeDTO.fromJson(Map<String, dynamic> json) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ExamGradeDTO &&
              runtimeType == other.runtimeType &&
              examId == other.examId &&
              studentId == other.studentId;

  @override
  int get hashCode =>
      examId.hashCode ^
      studentId.hashCode;

  @override
  String toString() {
    return 'ExamGradeDTO{examId: $examId, studentId: $studentId, studentName: $studentName, grade: $grade}';
  }
}