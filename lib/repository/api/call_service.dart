import 'package:aluco/model/student_call.dart';
import 'package:aluco/repository/core/abstract_call_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

import 'API.dart';

class CallService implements AbstractCallRepository {
  final _dio = DioBuilder.getDio();

  @override
  Future<List<StudentCall>> getClassStudentsCallOnDate(
      int classId, String date) async {
    try {
      final response =
          await _dio.get<dynamic>('$CALL/$SINGLE_CLASS/$classId?$DATE=$date');
      return List.generate(response.data.length,
          (int i) => StudentCall.fromJson(response.data[i]));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> changeStudentCall(StudentCall studentCall) async {
    await _dio.post<dynamic>(CALL, data: studentCall.toJson());
  }
}
