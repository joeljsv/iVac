import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';

class CenterLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Lottie.asset("assets/images/load.json", fit: BoxFit.fill),
    );
  }
}

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widt = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        children: [
          Text(
            "No Centers Found",
            style: kTitleTextstyle,
          ),
          Container(
            // height: 175,
            width: widt - 20,
            child: Lottie.asset("assets/images/empty.json",
                width: widt - 20, height: height / 4),
          ),
        ],
      ),
    );
  }
}

loading(BuildContext context, {@required String title}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            title: Text('$title'),
            content: Text('Please wait...'),
          ));
}

popUpwithButton(BuildContext context,
    {@required String title, @required body}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            title: Text('$title'),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$body"),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ));
}
