import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacinefinder/models/centers.dart';
import 'package:vacinefinder/utils/service.dart';

class CenterProvider with ChangeNotifier {
  List<Centers> centers = [];
  List<Centers> savedCenters = [];
  final api = API_URL;
  final headers = HEADERS;
  final day = DateTime.now().day;
  final month = DateTime.now().month;
  final year = DateTime.now().year;

  List<Centers> get getSavedCenter => savedCenters.toList();

// Extract Data
  List<Centers> extractData(json) {
    try {
      centers.clear();
      if (json['centers'] != null && json['centers'] != []) {
        json['centers'].forEach((v) {
          centers.add(new Centers.fromJson(v));
        });
      }

      return centers.toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

// Fetch With Pin
  fetchWithPin({pincode = 110001}) async {
    try {
      final date = "$day-$month-$year";
      print(date);
      final Uri url = Uri.parse(
        "$api/appointment/sessions/public/calendarByPin?pincode=$pincode&date=$date",
      );
      final result = await http.get(url, headers: headers);
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      final List<Centers> centerList = extractData(json);
      return centerList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  fetchWithDistrict({disId = 512}) async {
    try {
      final date = "$day-$month-$year";

      final Uri url = Uri.parse(
        "$api/appointment/sessions/public/calendarByDistrict?district_id=$disId&date=$date",
      );
      final result = await http.get(url, headers: headers);
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      final List<Centers> centerList = extractData(json);
      return centerList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  fetchStartIntial() async {
    try {
      final date = "$day-$month-$year";
      final pincode = 110001;
      // prefs.getString('pincode') ?? "110001";

      final Uri url = Uri.parse(
        "$api/appointment/sessions/public/calendarByPin?pincode=$pincode&date=$date",
      );
      final result = await http.get(url, headers: headers);
      final json = jsonDecode(result.body) as Map<String, dynamic>;
      final List<Centers> centerList = extractData(json);
      return centerList;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  fetchSavedCenters() async {
    try {
      savedCenters.clear();
      List<Centers> centerList = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final date = "$day-$month-$year";
      final List<String> pincodeList = prefs.getStringList('pincode') ?? [];
      final List<String> centerIdList = prefs.getStringList('centerId') ?? [];
      List temp = [];
      if (pincodeList.isNotEmpty && centerIdList.isNotEmpty) {
        for (int i = 0; i < pincodeList.length; i++) {
          final pincode = pincodeList[i];
          final Uri url = Uri.parse(
            "$api/appointment/sessions/public/calendarByPin?pincode=$pincode&date=$date",
          );
          final result = await http.get(url, headers: headers);
          final json = jsonDecode(result.body) as Map<String, dynamic>;
          centerList = extractData(json);
          centerList.forEach((center) {
            if (centerIdList.contains(center.centerId.toString())) {
              savedCenters.add(center);
              temp.add(center);
            }
          });
          savedCenters.toList();
        }
        //     pincodeList.forEach((pincode) async {
        // temp.add("value");
        //     });
      }
      print(temp);

      return savedCenters.toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  saveCenters(Centers savecen) async {
    try {
      final pin = savecen.pincode.toString();
      final cId = savecen.centerId.toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Firebase.initializeApp();
      final List<String> pincodeList = prefs.getStringList('pincode') ?? [];
      final List<String> centerIdList = prefs.getStringList('centerId') ?? [];
      if (!pincodeList.contains(pin)) {
        pincodeList.add(pin);
        pincodeList.toList();
        prefs.setStringList("pincode", pincodeList);
      }

      if (!centerIdList.contains(cId)) {
        await FirebaseMessaging.instance.subscribeToTopic(cId);
        final Uri url = Uri.parse(
          "$NOTIFY/$pin/$cId.json",
        );
        await http.put(url, body: json.encode({"notify": true}));
        centerIdList.add(cId);
        centerIdList.toList();
        prefs.setStringList("centerId", centerIdList);
      }
      print("Done");
      savedCenters.add(savecen);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }


  // Delete Center
  deleteCenter(Centers savecen) async {
    try {
      final pin = savecen.pincode.toString();
      final cId = savecen.centerId.toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Firebase.initializeApp();
      final List<String> centerIdList = prefs.getStringList('centerId') ?? [];


      if (!centerIdList.contains(cId)) {
        await FirebaseMessaging.instance.unsubscribeFromTopic(cId);
        centerIdList.removeWhere((id) => id.toString()==cId);
        
        centerIdList.toList();
        prefs.setStringList("centerId", centerIdList);
      }
      savedCenters.removeWhere((id) => id.toString()==cId);
  
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
