class ExamsPeriod {
  int examId;
  String examName;
  List<int> examDate;
  int weight;
  int studentId;
  String studentName;
  double grade;
  int periodYear;
  bool recExam;

  ExamsPeriod(
      {this.examId,
      this.examName,
      this.examDate,
      this.weight,
      this.studentId,
      this.studentName,
      this.grade,
      this.periodYear,
      this.recExam});

  ExamsPeriod.fromJson(Map<String, dynamic> json) {
    examId = json['examId'];
    examName = json['examName'];
    examDate = json['examDate'].cast<int>();
    weight = json['weight'];
    studentId = json['studentId'];
    studentName = json['studentName'];
    grade = json['grade'];
    periodYear = json['periodYear'];
    recExam = json['recExam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['examId'] = examId;
    data['examName'] = examName;
    data['examDate'] = examDate;
    data['weight'] = weight;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['grade'] = grade;
    data['periodYear'] = periodYear;
    data['recExam'] = recExam;
    return data;
  }

  @override
  String toString() {
    return 'ExamsPeriod{examId: $examId, examName: $examName, examDate: $examDate, weight: $weight, studentId: $studentId, studentName: $studentName, grade: $grade, periodYear: $periodYear, recExam: $recExam}';
  }
}
