import 'package:aluco/model/class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class StudentCallScreen extends StatefulWidget {
  const StudentCallScreen({this.classe});

  final Class classe;

  @override
  _StudentCallScreenState createState() => _StudentCallScreenState();
}

class _StudentCallScreenState extends State<StudentCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF389952), //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Chamada',
          style: TextStyle(color: Color(0xFF389952), fontSize: 28),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              MaterialCommunityIcons.getIconData('face-profile'),
              size: 38,
              color: const Color(0xFF389952),
            ),
          ),
        ],
      ),
      /*body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, i) => Container(
                padding: const EdgeInsets.all(16),
                  color: students[i].called == null ? null : students[i].called ? Colors.green[200] : Colors.red[200],
                  key: ValueKey(i),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(students[i].photoUrl),
                            ),
                          ),
                          const Spacer(flex: 1),
                          Expanded(
                            flex: 7,
                            child: Text(
                              students[i].name.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(child: Icon(Icons.check), onTap: () {
                                  setState(() {
                                    students[i].called = true;
                                  });
                                },),
                                GestureDetector(child: Icon(Icons.close), onTap: () {
                                  setState(() {
                                    students[i].called = false;
                                  });
                                },),
                                Icon(Icons.info_outline),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),),
              itemCount: students.length,
            ),
          ),
          //Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: RaisedButton(
                shape: Border.all(color: Colors.black),
                onPressed: () {},
                child: Text(
                  'FINALIZAR CHAMADA',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}

/*final students = [
  Student(
    id: 1,
    name: 'Aline Queiroz Peireira',
    photoUrl:
        'https://images.pexels.com/photos/346796/pexels-photo-346796.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ),
  Student(
    id: 2,
    name: 'Bruno da Silva Gois',
    photoUrl:
        'https://images.pexels.com/photos/1416736/pexels-photo-1416736.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ),
  Student(
    id: 3,
    name: 'Diego Castro Borges',
    photoUrl:
        'https://images.pexels.com/photos/35537/child-children-girl-happy.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ),
  Student(
    id: 4,
    name: 'Ellen Santos Dumont',
    photoUrl:
        'https://images.pexels.com/photos/36483/aroni-arsa-children-little.jpg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ),
  Student(
    id: 5,
    name: 'Bob Dylan',
    photoUrl:
        'https://images.pexels.com/photos/1598122/pexels-photo-1598122.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ),
  Student(
    id: 6,
    name: 'John Lennon',
    photoUrl:
        'https://images.pexels.com/photos/189857/pexels-photo-189857.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ),
  Student(
    id: 7,
    name: 'Sir Paulete',
    photoUrl:
        'https://images.pexels.com/photos/1912868/pexels-photo-1912868.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
  ),
];*/
