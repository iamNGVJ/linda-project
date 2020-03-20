import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hit_attendance_v2/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _continue = false;
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 10), (){
      setState(() {
        _continue = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/1.jpg"),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Center(child: Image.asset("assets/images/index.jpeg", height: 200, width: 0.8 * _width)),
                _continue == false ? SpinKitCircle(color: Colors.white,) : MaterialButton(
                  child: Container(
                    alignment: Alignment.center,
                    width: 0.3 * _width,
                    decoration: BoxDecoration(
                      color: Color(0xFFFEB400),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                          color: Color(0xFF00145C),
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
