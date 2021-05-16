import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/models/centers.dart';
import 'package:vacinefinder/provider/centers.dart';
import 'package:vacinefinder/provider/locationPro.dart';

class DropDownCity extends StatelessWidget {
  const DropDownCity({
    Key key,
    @required this.city,
  }) : super(key: key);

  final Widget city;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(0xFFE5E5E5),
        ),
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset("assets/icons/maps-and-flags.svg"),
          SizedBox(width: 20),
          Expanded(
            child:city
          ),
        ],
      ),
    );
  }
}
