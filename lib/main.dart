import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hit_attendance_v2/ui/splash_screen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fingerprint Attendance Application",
      home: SplashScreen()
    );
  }
}
