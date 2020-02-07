import 'base_model.dart';

enum ClassStatus { created, started, closed }

class Class implements BaseModel<Class> {
  int id;
  String name;
  String description;
  double minimumAverage;
  int maxQntAbsence;
  ClassStatus classStatus;

  Class();

  @override
  int getId() => id;

  ClassStatus getClassStatus(String s) {
    if (s == 'CREATED') {
      return ClassStatus.created;
    } else if (s == 'STARTED') {
      return ClassStatus.started;
    }
    return ClassStatus.closed;
  }

  @override
  Class fromJson(Map<String, dynamic> json) {
    return Class()
      ..id = json['id']
      ..name = json['name']
      ..description = json['description']
      ..classStatus = getClassStatus(json['classStatus'] ?? 'CREATED');
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'classStatus': classStatus?.index ?? 0,
    };
  }

  Map<String, dynamic> toJsonConfig() {
    return <String, dynamic>{
      'classId': id,
      'minimumAverage': minimumAverage,
      'maxQntAbsence': maxQntAbsence
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Class && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Class{id: $id, name: $name, description: $description, minimumAverage: $minimumAverage, maxQntAbsence: $maxQntAbsence, classStatus: $classStatus}';
  }
}
