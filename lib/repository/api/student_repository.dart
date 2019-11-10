import 'package:aluco/model/student.dart';
import 'package:aluco/repository/core/abstract_student_repository.dart';

import 'package:aluco/repository/core/base_repository.dart';

class StudentRepository extends BaseRepository<Student>
    implements AbstractStudentRepository {

  StudentRepository(String basePath, Student instance)
      : super(basePath, instance);
}
