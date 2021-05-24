import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vacinefinder/models/user/user.dart';
import 'package:vacinefinder/provider/user.dart';
import 'package:vacinefinder/screens/user/scan.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
import 'package:vacinefinder/utils/loading.dart';

class QrShowScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppUser user =
        Provider.of<UserProvider>(context, listen: false).userData;
    final data = {
      "name": user.name,
      "phone": user.phone,
      "userid": user.userid,
    };
    return Center(
        child: user.isShop
            ? shopQr(data)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => QRcodeScanner(),
                        ),
                      );
                      loading(context, title: "Adding");
                      await Provider.of<UserProvider>(context, listen: false)
                          .addVisit(data: result);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.search),
                    label: Text(
                      "Scan QRcode",
                      style: kHeadingTextStyle.copyWith(fontSize: 26),
                    ),
                  ),
                  Text(
                    "Scan to add Visit list ",
                    style: kHeadingTextStyle.copyWith(fontSize: 26),
                  ),
                ],
              ));
  }

  Column shopQr(Map<String, String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QrImage(data: data.toString()),
        Text(
          "Scan this code ",
          style: kHeadingTextStyle.copyWith(fontSize: 26),
        ),
      ],
    );
  }
}
