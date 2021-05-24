import 'package:flutter/material.dart';
import 'package:vacinefinder/models/vaccine/centers.dart';
import 'package:vacinefinder/screens/vacine/CenterDetailScreen.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
import 'package:vacinefinder/widgets/vaccine/counter.dart';

class CenterList extends StatelessWidget {
  const CenterList({
    Key key,
    @required this.centersDat,
  }) : super(key: key);

  final List<Centers> centersDat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: centersDat.length,
        itemBuilder: (BuildContext build, index) {
          final Centers center = centersDat[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CenterDetailScreen(
                    centers: center,
                  ),
                ),
              );
            },
            child: CenterSumarry(center: center),
          );
        });
  }
}

class CenterSumarry extends StatelessWidget {
  const CenterSumarry({
    Key key,
    @required this.center,
  }) : super(key: key);

  final Centers center;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 30,
            color: shadowColor,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            isThreeLine: true,
            // leading: Icon(
            //   Icons.local_hospital,
            //   color: appPrimaryColor,
            // ),
            trailing: Text(
              center.feeType,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: appPrimaryColor),
            ),
            title: Text(
              center.name,
              style: kTitleTextstyle,
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              "Pincode: ${center.pincode}\nAddress: ${center.address}",
              style: kSubTextStyle.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          Hero(
              tag: center.centerId,
              child: SessionsList(session: center.sessions)),
        ],
      ),
    );
  }
}

class SessionsList extends StatelessWidget {
  const SessionsList({
    Key key,
    @required this.session,
  }) : super(key: key);

  final List session;
  @override
  Widget build(BuildContext context) {
    int totalCap = 0;
    int ageLim = 45;
    session.forEach((sess) {
      totalCap += sess.availableCapacity;
      if (sess.minAgeLimit != 45) {
        ageLim = sess.minAgeLimit;
      }
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Counter(
          color: appOrangeColor,
          number: "${session.length}",
          title: "Avilable\nDates",
        ),
        Counter(
          color: appredColor,
          number: "$totalCap",
          title: "Total\nCapacity",
        ),
        Counter(
          color: appgrrenColor,
          number: "$ageLim+",
          title: "Age\nLimit",
        ),
      ],
    );
  }
}
