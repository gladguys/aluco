import 'period_content.dart';

class StudentGrades {
  PeriodContent periodOne;
  PeriodContent periodTwo;
  PeriodContent periodThree;
  PeriodContent periodFour;
  String status;
  String studentName;
  double average;

  List<PeriodContent> get allPeriodsContent => [
        periodOne,
        periodTwo,
        periodThree,
        periodFour,
      ];

  StudentGrades(
      {this.periodOne,
      this.periodTwo,
      this.periodThree,
      this.periodFour,
      this.status,
      this.studentName,
      this.average});

  StudentGrades.fromJson(Map<String, dynamic> json) {
    periodOne = json['periodOne'] != null
        ? PeriodContent.fromJson(json['periodOne'])
        : null;
    periodTwo = json['periodTwo'] != null
        ? PeriodContent.fromJson(json['periodTwo'])
        : null;
    periodThree = json['periodThree'] != null
        ? PeriodContent.fromJson(json['periodThree'])
        : null;
    periodFour = json['periodFour'] != null
        ? PeriodContent.fromJson(json['periodFour'])
        : null;
    status = json['status'];
    studentName = json['studentName'];
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (periodOne != null) {
      data['periodOne'] = periodOne.toJson();
    }
    if (periodTwo != null) {
      data['periodTwo'] = periodTwo.toJson();
    }
    if (periodThree != null) {
      data['periodThree'] = periodThree.toJson();
    }
    if (periodFour != null) {
      data['periodFour'] = periodFour.toJson();
    }
    data['status'] = status;
    data['studentName'] = studentName;
    data['average'] = average;
    return data;
  }

  @override
  String toString() {
    return 'StudentGrades{periodOne: $periodOne, periodTwo: $periodTwo, periodThree: $periodThree, periodFour: $periodFour, status: $status, studentName: $studentName, average: $average}';
  }
}
