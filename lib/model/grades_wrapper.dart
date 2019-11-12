import 'student_grade.dart';

class GradesWrapper {
  List<StudentGrade> studentsGrades;

  GradesWrapper(this.studentsGrades);

  GradesWrapper.fromJson(Map<String, dynamic> json) {
    final dynamic grades = json['grades'];
    studentsGrades =
        List.generate(grades, (i) => StudentGrade.fromJson(grades[i]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grades'] = studentsGrades;
    return data;
  }
}
