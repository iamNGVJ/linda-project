import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_auth/local_auth.dart';

class LecturerLoginScreen extends StatefulWidget {
  @override
  _LecturerLoginScreenState createState() => _LecturerLoginScreenState();
}

class _LecturerLoginScreenState extends State<LecturerLoginScreen> {
  LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  String _authorised = "Not Authorised";

  Future<void> _checkBiometrics() async{
    bool canCheckBiometrics;
    try{
      canCheckBiometrics = await auth.canCheckBiometrics;
    }on PlatformException catch(e){
      print(e);
    }

    if(!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async{
    bool authenticated = false;
    try{
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: "Hello. Please Use Your Fingerprint To Get Access",
        useErrorDialogs: true,
        stickyAuth: true
      );
    }on PlatformException catch(e){
      print(e);
    }

    if(!mounted) return;

    setState(() {
      _authorised = authenticated ? "Authenticated" : "Not Authenticated";
    });
  }

  _authenticateWithFinger() async{
    await _checkBiometrics();
    if(_canCheckBiometrics){
      _authenticate();
      print(_authorised);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: _width,
            height: _height,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Icon(Icons.arrow_back),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    InkWell(
                      child: Icon(Icons.close),
                      onTap: (){
                        exit(0);
                      },
                    )
                  ],
                ),
                SizedBox(height: 0.1 * _height),
                Text(
                  "Fingerprint Based Attendance",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Tap The Image Below To Authenticate",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 0.2 * _height,),
                Container(
                  child: InkWell(
                    child: Image(
                      image: AssetImage("assets/images/fingerprint.png",),
                      height: 0.35 * _height,
                      width: 0.35 * _width,
                    ),
                    onTap: _authenticateWithFinger,
                  ),
                ),
                _authorised == "Authorised" ? MaterialButton(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(0xFFFEB400),
                    ),
                    child: Text("CONTINUE"),
                  ),
                  onPressed: null,
                ) : SpinKitCircle(color: Color(0xFFFEB400)),
              ],
            )
          ),
        ),
      ),
    );
  }
}
