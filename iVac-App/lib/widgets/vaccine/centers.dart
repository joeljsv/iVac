import 'package:flutter/material.dart';
import 'package:vacinefinder/screens/vacine/addScreen.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "\nSaved Centers",
                style: kTitleTextstyle,
              )
            ],
          ),
          InfoCard(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
