import 'package:flutter/material.dart';

import 'class_info_screen.dart';

class StudentCallScreen extends StatefulWidget {
  @override
  _StudentCallScreenState createState() => _StudentCallScreenState();
}

class _StudentCallScreenState extends State<StudentCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chamada de Alunos'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => StudentCallScreen())),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        body: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, i) => Container(
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(students[i].photoUrl),
                        ),
                        SizedBox(width: 20,),
                        Text(students[i].name, overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  Icon(Icons.thumb_up, color: Colors.green,),
                  Icon(Icons.thumb_down, color: Colors.red,),
                  Icon(Icons.chrome_reader_mode),
                  SizedBox(width: 10,),
                ],
              )),
          separatorBuilder: (_, i) => Divider(),
          itemCount: students.length,
        ));
  }
}
