import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/models/centers.dart';
import 'package:vacinefinder/provider/centers.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
import 'package:vacinefinder/utils/loading.dart';
import 'package:vacinefinder/widgets/centerlist.dart';

class DisandPinList extends StatelessWidget {
  final pin;
  final dis;
  final tile;

  const DisandPinList(this.tile, {Key key, this.pin, this.dis})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CenterProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tile,
          style: TextStyle(
            color: appPrimaryColor,
          ),
        ),
      ),
      body: FutureBuilder(
          future: pin != null
              ? provider.fetchWithPin(pincode: pin)
              : provider.fetchWithDistrict(disId: dis),
          builder: (BuildContext build, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: Center(child: CenterLoading()));
            }
            final List<Centers> centersDat = snap.data??[];
            if (centersDat.length > 0)
              return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: CenterList(centersDat: centersDat));
            return Empty();
          }),
    );
  }
}
