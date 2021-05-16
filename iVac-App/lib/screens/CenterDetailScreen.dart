import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vacinefinder/models/centers.dart';
import 'package:vacinefinder/provider/centers.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
import 'package:vacinefinder/utils/loading.dart';
import 'package:vacinefinder/widgets/centerlist.dart';

// MeetingDataSource _getCalendarDataSource(List session) {
//   List<Meeting> meetings = <Meeting>[];

//   DateTime exceptionDate = DateTime(2019, 12, 24);
//   session.forEach((sess) {
//     final dat= sess.date.toString().split("-");
//     meetings.add(Meeting(
//       eventName: 'Avilable Slots',
//       from: DateTime(int.parse(dat[2]),int.parse(dat[1]),int.parse(dat[0])),
//       to: DateTime.now().add(Duration(hours: 18)),
//       background: Colors.green,
//       isAllDay: false,
//       recurrenceRule: 'FREQ=DAILY;COUNT=1',
//       exceptionDates: <DateTime>[exceptionDate]));
//   });

//   return MeetingDataSource(meetings);
// }

class CenterDetailScreen extends StatelessWidget {
  final Centers centers;

  const CenterDetailScreen({Key key, this.centers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await launch("https://selfregistration.cowin.gov.in/");
          },
          isExtended: true,
          label: Text("Book Now")),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async{
              loading(context);
              await  Provider.of<CenterProvider>(context, listen: false).saveCenters(centers);
                    Navigator.of(context).pop();
                    done(context);             })
        ],
        title: Text(
          centers.name,
          style: TextStyle(color: appPrimaryColor),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Hero(
                  tag: centers.centerId,
                  child: SessionsList(
                    session: centers.sessions,
                  )),
            ),
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: centers.sessions.length,
                itemBuilder: (BuildContext build, index) {
                  final sess = centers.sessions[index];
                  final dat = sess.date.toString().split("-");
                  final dateTime = DateTime(
                      int.parse(dat[2]), int.parse(dat[1]), int.parse(dat[0]));
                  return ListTile(
                    leading: Column(
                      children: [
                        Text(
                          DateFormat("MMM").format(dateTime),
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          dateTime.day.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            color: appPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    title: Text(
                      "Avilable Slots",
                      style: kTitleTextstyle,
                    ),
                    subtitle: Column(
                      children: [
                        for (int i = 0; i < sess.slots.length; i++)
                          Text(
                            sess.slots[i],
                            style: kSubTextStyle.copyWith(
                                color: appgrrenColor,
                                fontWeight: FontWeight.bold),
                          )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
