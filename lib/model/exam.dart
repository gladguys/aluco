import 'base_model.dart';

class Exam implements BaseModel<Exam> {
  int id;
  int weight;
  int classId;
  String name;
  String description;
  String creationDate;
  String examDate;

  Exam();

  @override
  int getId() => id;

  @override
  Exam fromJson(Map<String, dynamic> json) {
    return Exam()
      ..id = json['id']
      ..weight = json['weight']
      ..classId = json['classId']
      ..name = json['name']
      ..description = json['description']
      ..creationDate = json['creationDate']
      ..examDate = json['examDate'];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'weight': weight,
      'classId': classId,
      'name': name,
      'description': description,
      'creationDate': creationDate,
      'examDate': examDate
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
    return 'Exam{id: $id, weight: $weight, name: $name, description: $description, creationDate: $creationDate, examDate: $examDate}';
  }
}