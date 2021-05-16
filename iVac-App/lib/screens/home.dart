import 'package:flutter/material.dart';
import 'package:vacinefinder/widgets/centers.dart';
import 'package:vacinefinder/widgets/dropDownCity.dart';
import 'package:vacinefinder/widgets/my_header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// Notification

  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  final city = ['Indonesia', 'Bangladesh', 'United States', 'Japan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
            ),
            
            const SizedBox(height: 20),
            const CenterDetails(),
          ],
        ),
      ),
    );
  }
}
