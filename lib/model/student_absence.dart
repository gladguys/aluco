class StudentAbsence {
  int id;
  int studentId;
  int quantity;
  int classId;

  StudentAbsence({this.id, this.studentId, this.quantity, this.classId});

  StudentAbsence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    quantity = json['quantity'];
    classId = json['classId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentId'] = studentId;
    data['quantity'] = quantity;
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
    return 'StudentAbsence{id: $id, studentId: $studentId, quantity: $quantity, classId: $classId}';
  }
}
