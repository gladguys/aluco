import 'student.dart';

class StudentMarked {
  final Student student;
  bool marked;

  StudentMarked({this.student, this.marked = false});

  @override
  String toString() {
    return 'StudentMarked{student: $student, marked: $marked}';
  }
}