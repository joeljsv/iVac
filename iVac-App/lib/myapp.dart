import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacinefinder/screens/home.dart';
import 'package:vacinefinder/screens/intro.dart';
import 'package:vacinefinder/utils/loading.dart';

class IndexPageStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    indexRout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
     await   Firebase.initializeApp();
await FirebaseMessaging.instance.getToken().then((value) => print(value));
      if (prefs.containsKey("loggedin")) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        prefs.setString("loggedin", "loggedin");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => IntroPage()));
      }
    }

    return Scaffold(
          body: Center(
            child: FutureBuilder(
        future:indexRout() ,
        builder: (BuildContext build,snap){
            if(snap.connectionState==ConnectionState.waiting){
              return CenterLoading();
              
            }
            else{
              return CenterLoading();
            }
        }),
          ),
    );
  }
}
