import 'package:flutter/material.dart';
import 'package:hit_attendance_v2/models/student.dart';
import 'package:hit_attendance_v2/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Student> studentList;
  int count = 0;

  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<Student>> studentListFuture = databaseHelper.getStudentList();
      studentListFuture.then((studentList){
        setState(() {
          this.studentList = studentList;
          this.count = studentList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    if(studentList == null){
      studentList = List<Student>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: Color(0xFFFEB400),),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Classes",
          style: TextStyle(
            color: Color(0xFFFEB400)
          ),
        ),
        backgroundColor: Color(0xFF00145C),
      ),
      body: Container(
        height: _height,
        width: _width,
        child: count != 0 ? ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int position){
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(this.studentList[position].fullname,),
                subtitle: Text(this.studentList[position].schlId),
                trailing: Icon(Icons.delete),
              ),
            );
          },
        ) : Center(child: Text("No registered student yet"),)
      ),
    );
  }
}
