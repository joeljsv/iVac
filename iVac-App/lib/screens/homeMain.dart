import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';

import 'user/QRScanner.dart';
import 'user/profile.dart';
import 'vacine/home.dart';

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(),
      QrShowScanner(),
      ProfilePage(),
    ];
    return Scaffold(
        body: screens[index],

        bottomNavigationBar: ConvexAppBar(
          backgroundColor: introBackgroundColor,

          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.search, title: 'Qrcode'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          //optional, default as 0
          onTap: (int i) {
            setState(() {
              index = i;
            });
          },
        ));
  }
}
