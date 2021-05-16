import 'package:flutter/material.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';

class Counter extends StatelessWidget {
  final String number;
  final Color color;
  final String title;
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "$number",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: color,
          ),
        ),
        Text(
          title,
          style: kSubTextStyle.copyWith(
            color: Colors.black
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
