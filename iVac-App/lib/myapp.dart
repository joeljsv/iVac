import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/provider/user.dart';
import 'package:vacinefinder/screens/intro.dart';
import 'screens/homeMain.dart';
import 'utils/apptheme/constant.dart';

class IndexPageStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    indexRout() async {
      await Firebase.initializeApp();
      final auth = FirebaseAuth.instance.currentUser;
      if (auth != null) {
       await Provider.of<UserProvider>(context,listen: false).autoLogin();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => MainHomeScreen(),
          ),
        );
      } else
         Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => IntroPage(),
          ),
        );
    }

    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: indexRout(),
            builder: (BuildContext build, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: Image.asset(
                          'assets/icon.png',
                          fit: BoxFit.fitHeight,
                          height: 70,
                        ),
                      ),
                      // SizedBox(
                      //   width: 4,
                      // ),
                      Text(
                        'iVac',
                        style: kHeadingTextStyle,
                      )
                    ],
                  ),
                );
              } else {
                return IntroPage();
              }
            }),
      ),
    );
  }
}
