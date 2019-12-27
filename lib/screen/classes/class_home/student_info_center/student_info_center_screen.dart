import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/repository/api/call_repository.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../class_home_bloc.dart';

class StudentInfoCenterScreen extends StatefulWidget {
  const StudentInfoCenterScreen(this.student);

  final Student student;

  @override
  _StudentInfoCenterScreenState createState() =>
      _StudentInfoCenterScreenState();
}

class _StudentInfoCenterScreenState extends State<StudentInfoCenterScreen> {
  final _studentRepository = G<StudentRepository>();
  final _callRepository = G<CallRepository>();
  final _classHomeBloc = BlocProvider.getBloc<ClassHomeBloc>();

  Future<Student> getInfoStudentFuture;
  Future<List<StudentCall>> getStudentCallsFuture;

  Student get student => widget.student;

  @override
  void initState() {
    //getInfoStudentFuture = _studentRepository.getById(student.id);
    //getStudentCallsFuture = _callRepository.getStudentCalls(student.id);

    _studentRepository.getById(student.id).then((data) => print(data));
    _callRepository
        .getStudentCalls(student.id, _classHomeBloc.pickedClass.id)
        .then((data) => print(data));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
