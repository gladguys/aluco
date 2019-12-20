import 'exams_period.dart';

class PeriodContent {
  List<ExamsPeriod> examsPeriod;
  double average;

  PeriodContent({this.examsPeriod, this.average});

  PeriodContent.fromJson(Map<String, dynamic> json) {
    if (json['examsPeriod'] != null) {
      examsPeriod = <ExamsPeriod>[];
      json['examsPeriod'].forEach((dynamic v) {
        examsPeriod.add(ExamsPeriod.fromJson(v));
      });
    }
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (examsPeriod != null) {
      data['examsPeriod'] = examsPeriod.map((v) => v.toJson()).toList();
    }
    data['average'] = average;
    return data;
  }

  @override
  String toString() {
    return 'PeriodContent{examsPeriod: $examsPeriod, average: $average}';
  }
}
