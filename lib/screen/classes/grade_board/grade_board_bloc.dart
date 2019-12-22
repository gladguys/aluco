import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/model/student_grades.dart';
import 'package:aluco/repository/api/class_repository.dart';

class GradeBoardBloc {
  final _classRepository = G<ClassRepository>();

  Future<List<StudentGrades>> getGradesBoard(int classId) async {
    try {
      return await _classRepository.getGradesBoard(classId);
    } catch (e) {
      rethrow;
    }
  }
}
