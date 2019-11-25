import 'base_model.dart';

class LessonPlan extends BaseModel<LessonPlan> {
  int id;
  int classId;
  int teacherId;
  String content;
  String metodology;
  String homework;
  String classwork;
  String notes;
  String lessonDate;

  LessonPlan(
      {this.id,
        this.content,
        this.metodology,
        this.homework,
        this.classwork,
        this.notes,
        this.lessonDate,
        this.classId,
        this.teacherId});

  @override
  int getId() {
    return id;
  }

  @override
  LessonPlan fromJson(Map<String, dynamic> json) {
    return LessonPlan()
      ..id = json['id']
      ..content = json['content']
      ..metodology = json['metodology']
      ..homework = json['homework']
      ..classwork = json['classwork']
      ..notes = json['notes']
      ..lessonDate = json['lessonDate']
      ..classId = json['classId']
      ..teacherId = json['teacherId'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['metodology'] = metodology;
    data['homework'] = homework;
    data['classwork'] = classwork;
    data['notes'] = notes;
    data['lessonDate'] = lessonDate;
    data['classId'] = classId;
    data['teacherId'] = teacherId;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LessonPlan &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'LessonPlan{id: $id, content: $content, lessonDate: $lessonDate}';
  }
}