import 'package:aluco/enums/call_status.dart';

class StudentCall {
  int id;
  int studentId;
  String studentName;
  int classId;
  int numberCall;
  CallStatus status;
  String date;

  StudentCall(
      {this.id,
      this.studentId,
      this.studentName,
      this.classId,
      this.status,
      this.date});

  StudentCall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    studentName = json['studentName'];
    classId = json['classId'];
    numberCall = json['numberCall'];
    status = getCallStatusFromString(json['status']);
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['studentId'] = studentId;
    data['studentName'] = studentName;
    data['classId'] = classId;
    data['numberCall'] = numberCall;
    data['status'] = getIntFromCallStatus(status);
    data['date'] = date;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentCall &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'StudentCall{id: $id, studentId: $studentId, studentName: $studentName, classId: $classId, status: $status, date: $date, numberCall: $numberCall}';
  }
}
