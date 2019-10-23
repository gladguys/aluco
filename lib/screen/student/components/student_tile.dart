import 'package:aluco/model/student.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  const StudentTile(this.student);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(student.id),
      leading: AvataaarImage(
        avatar: Avataaar.random(),
        errorImage: Icon(Icons.error),
        placeholder: const CircularProgressIndicator(),
        width: 128.0,
      ),
      title: Text(student.name),
      subtitle: Text(student?.email ?? ''),
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {}),
    );
  }
}
