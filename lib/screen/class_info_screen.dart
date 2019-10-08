import 'package:easyteach/model/class.dart';
import 'package:easyteach/model/student.dart';
import 'package:flutter/material.dart';

import 'student_call_screen.dart';

class ClassInfoScreen extends StatelessWidget {
  ClassInfoScreen({@required this.classe});

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(classe.name),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => StudentCallScreen())),
        child: Icon(Icons.spellcheck),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1),
          itemBuilder: (context, i) => CircleAvatar(
            backgroundImage: NetworkImage(students[i].photoUrl),
          ),
          itemCount: students.length,
        ),
      ),
    );
  }
}

final students = [
  Student(
      name: 'Billy Joel',
      photoUrl:
          'https://images.pexels.com/photos/346796/pexels-photo-346796.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
  Student(
      name: 'Frodo Bolseiro',
      photoUrl:
          'https://images.pexels.com/photos/1416736/pexels-photo-1416736.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
  Student(
      name: 'João Bobo',
      photoUrl:
          'https://images.pexels.com/photos/35537/child-children-girl-happy.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
  Student(
      name: 'Martina Rings',
      photoUrl:
          'https://images.pexels.com/photos/36483/aroni-arsa-children-little.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
  Student(
      name: 'Bob Dylan',
      photoUrl:
          'https://images.pexels.com/photos/1598122/pexels-photo-1598122.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
  Student(
      name: 'John Lennon',
      photoUrl:
          'https://images.pexels.com/photos/189857/pexels-photo-189857.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
  Student(
      name: 'Sir Paulete',
      photoUrl:
          'https://images.pexels.com/photos/1912868/pexels-photo-1912868.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
];
