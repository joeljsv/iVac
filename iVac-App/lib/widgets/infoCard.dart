import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/models/centers.dart';
import 'package:vacinefinder/provider/centers.dart';
import 'package:vacinefinder/utils/loading.dart';

import 'centerlist.dart';

class InfoCard extends StatelessWidget {
  final bool saved;
  const InfoCard({
    Key key,
    this.saved = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final centers = saved
    //     ?
    //     : () => {};
    fetchS() async {
      final List<Centers> center =
          await Provider.of<CenterProvider>(context, listen: false)
              .fetchSavedCenters();
      return center;
    }

    return FutureBuilder(
        future: fetchS(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CenterLoading();
          }

          if (!snapshot.hasError)
            return Consumer<CenterProvider>(builder: (_, pro, __) {
              List centersDat = pro.getSavedCenter ?? [];
              
              if (centersDat.length > 0)
                return CenterList(centersDat: centersDat);
              else
               return Empty();
            });
          else
            return Empty();
        });
  }
}
