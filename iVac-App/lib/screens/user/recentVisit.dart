import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/models/user/user.dart';
import 'package:vacinefinder/provider/user.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';

class RecentVisit extends StatelessWidget {
  const RecentVisit({Key key, this.isShop = false}) : super(key: key);
  final isShop;
  @override
  Widget build(BuildContext context) {
    List<Myvisit> visitList =
        Provider.of<UserProvider>(context, listen: false).userData.visit;
    print("List ${visitList.length}");
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "\t\tTotal Vists: ${visitList.length}",
          style: kHeadingTextStyle.copyWith(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: 150.0,
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: isShop ? Axis.vertical : Axis.horizontal,
                itemCount: visitList.length,
                itemBuilder: (BuildContext context, int index) {
                  final place = visitList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          date(place),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${place.name}",
                                style: kHeadingTextStyle.copyWith(fontSize: 24),
                              ),
                              Text(
                                "Phone: ${place.phone}",
                                style: kSubTextStyle,
                              ),
                              Text(
                                "Time: ${DateFormat("hh:mm aa").format(DateTime.parse(place.time))}",
                                style: kSubTextStyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Column date(Myvisit place) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat("MMM").format(DateTime.parse(place.time)),
          style: TextStyle(fontSize: 20),
        ),
        Text(
          DateTime.parse(place.time).day.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: appPrimaryColor,
          ),
        ),
      ],
    );
  }
}
