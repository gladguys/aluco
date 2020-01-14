import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_absence.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/model/student_grades.dart';
import 'package:aluco/repository/api/call_repository.dart';
import 'package:aluco/repository/api/student_repository.dart';
import 'package:aluco/screen/classes/class_home/student_info_center/widgets/info_student.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../class_home_bloc.dart';
import 'widgets/student_absences_quantity.dart';
import 'widgets/student_calls.dart';
import 'widgets/student_grades_list.dart';

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
  Future<StudentAbsence> getStudentAbsencesFuture;
  Future<StudentGrades> getStudentGradesFuture;

  Student get student => widget.student;

  @override
  void initState() {
    getInfoStudentFuture = _studentRepository.getById(student.id);
    getStudentCallsFuture = _callRepository.getStudentCalls(
        student.id, _classHomeBloc.pickedClass.id);
    getStudentAbsencesFuture = _callRepository.getStudentAbsences(
        student.id, _classHomeBloc.pickedClass.id);
    getStudentGradesFuture = _callRepository.getStudentGrades(
        student.id, _classHomeBloc.pickedClass.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Central do Aluno',
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: ListView(
          children: <Widget>[
            FutureBuilder<Student>(
              future: getInfoStudentFuture,
              builder: (_, snapshotStudent) {
                if (snapshotStudent.hasData) {
                  return InfoStudent(snapshotStudent.data);
                }
                return Container();
              },
            ),
            const SizedBox(height: 24),
            Material(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: ExpansionTile(
                title: const Text('Histórico de Faltas'),
                children: <Widget>[
                  FutureBuilder<StudentAbsence>(
                    future: getStudentAbsencesFuture,
                    builder: (_, snapshotAbsence) {
                      if (snapshotAbsence.hasData) {
                        return StudentAbsencesQuantity(snapshotAbsence.data);
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<StudentCall>>(
                    future: getStudentCallsFuture,
                    builder: (_, snapshotCalls) {
                      if (snapshotCalls.hasData) {
                        return StudentCalls(snapshotCalls.data);
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Material(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: ExpansionTile(
                title: const Text('Notas'),
                children: <Widget>[
                  FutureBuilder<StudentGrades>(
                    future: getStudentGradesFuture,
                    builder: (_, snapshotGrades) {
                      if (snapshotGrades.hasData) {
                        return StudentGradesList(snapshotGrades.data);
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
