class StudentAbsence {
  int id;
  int studentId;
  int qtAbsences;
  int qtJustifiedAbsences;
  int classId;

  StudentAbsence({this.id, this.studentId, this.qtAbsences, this.classId});

  StudentAbsence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    qtAbsences = json['qtAbsences'];
    qtJustifiedAbsences = json['qtJustifiedAbsences'];
    classId = json['classId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentId'] = studentId;
    data['qtAbsences'] = qtAbsences;
    data['qtJustifiedAbsences'] = qtJustifiedAbsences;
    data['classId'] = classId;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAbsence &&
          runtimeType == other.runtimeType &&
          studentId == other.studentId;

  @override
  int get hashCode => studentId.hashCode;

  @override
  String toString() {
    return 'StudentAbsence{id: $id, studentId: $studentId, qtAbsences: $qtAbsences, qtJustifiedAbsences: $qtJustifiedAbsences, classId: $classId}';
  }
}
