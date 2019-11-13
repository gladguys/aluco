import 'exam_grade_dto.dart';

class GradesWrapper {
  List<ExamGradeDTO> studentsGrades;

  GradesWrapper(this.studentsGrades);

  GradesWrapper.fromJson(Map<String, dynamic> json) {
    final dynamic grades = json['grades'];
    studentsGrades =
        List.generate(grades, (i) => ExamGradeDTO.fromJson(grades[i]));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grades'] = studentsGrades;
    return data;
  }
}
