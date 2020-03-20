import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hit_attendance_v2/models/student.dart';
import 'package:hit_attendance_v2/utils/database_helper.dart';
import 'package:progress_dialog/progress_dialog.dart';

class StudentRegistration extends StatefulWidget {
  @override
  _StudentRegistrationState createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  String _fullname = "";
  String _registration = "";
  static var _classes = ["Part 1 SE", "Part 2 CS"];
  String _class = _classes[0];
  DatabaseHelper helper = DatabaseHelper();
  Student student;

  Future<bool> _save() async{
    int result;
    if(student.id != null){
      result = await helper.updateStudent(student);
    }else{
      result = await helper.insertStudent(student);
    }

    if(result != 0){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Color(0xFFFEB400),
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back, color: Color(0xFFFEB400),),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Student Registration",
          style: TextStyle(
            color: Color(0xFFFEB400)
          ),
        ),
        backgroundColor: Color(0xFF00145C),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10),
                  ListTile(
                    title: DropdownButton(
                      items: _classes.map((String dropDownStringItem){
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _class,
                      style: textStyle,
                      onChanged: (valueSelectedByUser){
                        setState(() {
                          _class = valueSelectedByUser;
                          student.klass = _class;
                        });
                      },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: TextStyle(
                          color: Color(0xFFFEB400),
                        ),
                        hintText: "e.g. Emily Machawira",
                        hintStyle: TextStyle(
                          color: Color(0xFFFEB400),
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 3.5,
                        ),
                      ),
                      // ignore: missing_return
                      validator: (value){
                        if(value.isEmpty){
                          return "Name is missing";
                        }else{
                          setState(() {
                            this._fullname = value.toString();
                            student.fullname = this._fullname;
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Registration Number",
                        labelStyle: TextStyle(
                          color: Color(0xFFFEB400),
                        ),
                        hintText: "e.g. HFFXXVM",
                        hintStyle: TextStyle(
                          color: Color(0xFFFEB400),
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 3.5,
                        ),
                      ),
                      // ignore: missing_return
                      validator: (value){
                        if(value.isEmpty){
                          return "Registration ID is missing";
                        }else{
                          setState(() {
                            this._registration = value.toString();
                            student.schlId = this._registration;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                    child: Container(
                      alignment: Alignment.center,
                      height: 0.09 * _height,
                      width: 0.7* _width,
                      decoration: BoxDecoration(
                        color: Color(0xFF00145C),
                        borderRadius: BorderRadius.circular(8.0,)
                      ),
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Color(0xFFFEB400)
                        )
                      ),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        pr = new ProgressDialog(
                          context,
                          type: ProgressDialogType.Normal,
                          isDismissible: true,
                          showLogs: true
                        );
                        pr.style(
                          message: "Registering a new student",
                          messageTextStyle: TextStyle(color: Color(0xFFFEB400)),
                          borderRadius: 10.0,
                          backgroundColor: Color(0xFF00145C),
                          progressWidget: SpinKitCircle(color: Color(0xFFFEB400)),
                        );
                        pr.show();
                        bool status = await _save();
                        if(status){
                          pr.update(
                            message: "Saved"
                          );
                          Timer(Duration(seconds: 2), (){
                            pr.dismiss();
                          });
                        }else{
                          pr.update(
                            message: "Registration failure",
                            messageTextStyle: TextStyle(color: Colors.red),
                          );
                          Timer(Duration(seconds: 2), (){
                            pr.dismiss();
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}
