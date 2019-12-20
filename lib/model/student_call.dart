import 'package:aluco/enums/call_status.dart';

class StudentCall {
  int id;
  int studentId;
  int classId;
  CallStatus status;
  String date;

  StudentCall({this.id, this.studentId, this.classId, this.status, this.date});

  StudentCall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    classId = json['classId'];
    status = getCallStatusFromString(json['status']);
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentId'] = studentId;
    data['classId'] = classId;
    data['status'] = getIntFromCallStatus(status);
    data['date'] = date;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentCall &&
          runtimeType == other.runtimeType &&
          studentId == other.studentId;

  @override
  int get hashCode => studentId.hashCode;

  @override
  String toString() {
    return 'StudentCall{id: $id, studentId: $studentId, classId: $classId, status: $status, date: $date}';
  }
}
