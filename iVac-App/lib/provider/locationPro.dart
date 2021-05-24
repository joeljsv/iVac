import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacinefinder/models/vaccine/districts.dart';
import 'package:vacinefinder/models/vaccine/states.dart';
import 'package:vacinefinder/utils/service.dart';

class LocationProv with ChangeNotifier {
  List<Districts> districts = [];
  List<States> states = [];
  final api = API_URL;
  final headers = HEADERS;

  List<States> get stateLis => states;
  List<Districts> get districList => districts;
// States
  Future fetchStates() async {
    states = [];
    String data = '';
    final Uri url = Uri.parse(
      "$api/admin/location/states",
    );
    final result = await http.get(url, headers: headers);
    data = result.body;
    final json = jsonDecode(data) as Map<String, dynamic>;

    if (json['states'] != null && json['states'].length > 0) {
      json['states'].forEach((v) {
        final ste = new States.fromJson(v);
        if (!states.contains(ste)) {
          states.add(ste);
        }
      });
    }
    print("hb");
    // stateLis.forEach((element) {
    //   print(element.stateId);
    // });
    return states.toList();
  }

  // Districts
  fetchDistricts({id = 16}) async {
    districts.clear();
    final Uri url = Uri.parse(
      "$api/admin/location/districts/$id",
    );
    final result = await http.get(url, headers: headers);

    final json = jsonDecode(result.body) as Map<String, dynamic>;
    if (json['districts'] != null) {
      json['districts'].forEach((v) {
        districts.add(new Districts.fromJson(v));
      });
    }
    return districts.toList();
  }
}
