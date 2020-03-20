import 'package:flutter/material.dart';
import 'package:hit_attendance_v2/ui/classes.dart';
import 'package:hit_attendance_v2/ui/splash_screen.dart';
import 'package:hit_attendance_v2/ui/student_registration.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Color(0xFFFEB400))),
        backgroundColor: Color(0xFF00145C),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  "Lecturer Menu",
                  style: TextStyle(
                    color: Color(0xFFFEB400),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF00145C),
              ),
            ),
            ListTile(
              title: Text(
                "Classes",
                style: TextStyle(
                  color: Color(0xFFFEB400)
                ),
              ),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen()));
              },
            ),
            ListTile(
              title: Text(
                "Register A Student",
                style: TextStyle(
                    color: Color(0xFFFEB400)
                ),
              ),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentRegistration()));
              },
            ),
            ListTile(
              title: Text(
                "Send Lesson Reminders",
                style: TextStyle(
                    color: Color(0xFFFEB400)
                ),
              ),
              onTap: null,
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Color(0xFFFEB400)
                ),
              ),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}