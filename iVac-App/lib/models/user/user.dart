import 'package:flutter/cupertino.dart';

class AppUser {
  String name;
  String phone;
  String userid;
  String address;
  String imageUrl;
  String pincode;
  bool isShop;
  List<Myvisit> visit;

  AppUser({
    this.address,
    this.imageUrl,
    this.isShop,
    this.name,
    this.pincode,
    this.phone,
    this.userid,
    this.visit,
  });

  AppUser.fromJson(
    Map<String, dynamic> json, {
    @required uname,
    @required userID,
    @required imageurl,
  }) {
    userid = userID;
    name = uname;
    imageUrl = imageurl;
    address = json['address'];
    phone = json['phone'];
    isShop = json['isShop'];
    pincode = json['pincode'];

    if (json['visit'] != null) {
      List<Myvisit> myS = [];
      final visitdata = json['visit'] as Map<String, dynamic>;
      visitdata.forEach((id, data) {
        myS.add(Myvisit(
          id: id,
          name: data['name'],
          phone: data['phone'].toString(),
          time: data['time'],
          userid: data['userid'],
        ));
      });
      visit = myS.toList();
    } else {
      visit = [];
    }
  }
}

class Myvisit {
  String id;
  String name;
  String phone;
  String userid;
  String time;

  Myvisit({
    this.time,
    this.name,
    this.phone,
    this.userid,
    this.id,
  });
}
