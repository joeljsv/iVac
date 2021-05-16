import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/models/states.dart';
import 'package:vacinefinder/provider/locationPro.dart';
import 'package:vacinefinder/screens/addScreen.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
import 'package:vacinefinder/utils/loading.dart';
import 'infoCard.dart';

class CenterDetails extends StatelessWidget {
  const CenterDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return savedCenter(context);
  }

  Padding savedCenter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Saved Centers\n",
                      style: kTitleTextstyle,
                    ),
                    TextSpan(
                      text: "Notifications on",
                      style: TextStyle(
                        color: appShadow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InfoCard(),
          const SizedBox(height: 20),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddCenter(),
                  ),
                );
              },
              icon: Icon(Icons.search),
              label: Text("Find Center")),
         
      
        ],
      ),
    );
  }
}
