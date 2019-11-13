import 'exam_grade_dto.dart';

class StudentGrades {
  List<ExamGradeDTO> exams;
  String average;
  String studentName;

  StudentGrades({this.exams, this.average, this.studentName});

  StudentGrades.fromJson(Map<String, dynamic> json) {
    if (json['exams'] != null) {
      exams = <ExamGradeDTO>[];
      json['exams'].forEach((dynamic v) => exams.add(ExamGradeDTO.fromJson(v)));
    }
    average = json['average'];
    studentName = json['studentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (exams != null) {
      data['exams'] = exams.map((v) => v.toJson()).toList();
    }
    data['average'] = average;
    data['studentName'] = studentName;
    return data;
  }
}