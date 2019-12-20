import 'base_model.dart';

class Exam implements BaseModel<Exam> {
  int id;
  int weight;
  int classId;
  int periodYear;
  String name;
  String description;
  String creationDate;
  String examDate;
  bool recExam;

  Exam();

  @override
  int getId() => id;

  @override
  Exam fromJson(Map<String, dynamic> json) {
    return Exam()
      ..id = json['id']
      ..weight = json['weight']
      ..classId = json['classId']
      ..periodYear = json['periodYear']
      ..name = json['name']
      ..description = json['description']
      ..creationDate = json['creationDate']
      ..examDate = json['examDate']
      ..recExam = json['recExam'];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'weight': weight,
      'classId': classId,
      'periodYear': periodYear,
      'name': name,
      'description': description,
      'creationDate': creationDate,
      'examDate': examDate,
      'recExam': recExam
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Exam &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Exam{id: $id, weight: $weight, classId: $classId, periodYear: $periodYear, name: $name, description: $description, creationDate: $creationDate, examDate: $examDate, recExam: $recExam}';
  }
}