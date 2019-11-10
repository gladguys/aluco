import 'base_model.dart';

class Class implements BaseModel<Class> {
  int id;
  String name;
  String description;

  Class();

  @override
  int getId() => id;

  @override
  Class fromJson(Map<String, dynamic> json) {
    return Class()
        ..id = json['id']
        ..name = json['name']
        ..description = json['description'];
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description
    };
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Class &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Class{name: $name, description: $description}';
  }
}