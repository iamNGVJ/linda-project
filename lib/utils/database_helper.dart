import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:hit_attendance_v2/models/student.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper; //singleton database helper
  static Database _database;

  String studentTable = 'student_table';
  String colId = 'id';
  String colFullName = 'fullname';
  String colSchlId = 'schlId';
  String colKlass = 'klass';
  String colDate = 'date';

  DatabaseHelper._createInstance(); //named constructor to create instance of db
  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance(); //so object can be executed only once - singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if (_database == null){
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async{
    //get directory path for both Android and IOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'students.db';

    //open/create database at given path
    var studentsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $studentTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colFullName TEXT, $colSchlId TEXT, $colKlass TEXT, $colDate TEXT)');
  }

  //fetch all students from database
  Future<List<Map<String, dynamic >>> getStudentMapList() async{
    Database db = await this.database;

//    var result = await db.rawQuery('SELECT * From $studentTable');
    var result = await db.query(studentTable);
    return result;
  }

  //insert a student into database
  Future<int> insertStudent(Student student) async{
    var db = await this.database;
    var result = await db.insert(studentTable, student.toMap());
    return result;
  }

  //update student details
  Future<int> updateStudent(Student student) async{
    var db = await this.database;
    var result = await db.update(studentTable, student.toMap(), where: '$colId = ?', whereArgs: [student.id]);
    return result;
  }

  //delete a student from database
  Future<int> deleteStudent(int id) async{
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $studentTable WHERE $colId = $id');
    return result;
  }

  //get number of student in a database;
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) from $studentTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Student>> getStudentList() async{
    var studentMapList = await getStudentMapList();
    int count = studentMapList.length;

    List<Student> studentList = List<Student>();
    for(int i = 0; i < count; i++){
      studentList.add(Student.fromMapObject(studentMapList[i]));
    }

    return studentList;
  }
}