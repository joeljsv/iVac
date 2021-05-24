import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:vacinefinder/models/user/user.dart';
import 'package:vacinefinder/utils/service.dart';

class UserProvider with ChangeNotifier {
  final String api = NOTIFY;
  AppUser userData;
// Sign in with googleF
  AppUser get user => userData;

  bool get isShop => userData.isShop;

  Future<User> signInWithGoogle() async {
    try {
      await Firebase.initializeApp();
      FirebaseAuth auth = FirebaseAuth.instance;
      User user;
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw ("Account Exist");
      } else if (e.code == 'invalid-credential') {
        throw ("Invalid Account ");
      }
    } catch (e) {
      throw ("Something went wrong try again.");
    }
  }

// Check User is exist or not
  Future<bool> userExistance() async {
    final User user = await signInWithGoogle();
    final Uri url = Uri.parse(
      "$api/user/${user.uid}.json",
    );

    try {
      final result = await http.get(url);
      if (result.body != "null") {
        print("ofty");
        await autoLogin();
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      throw ("Something went wrong try again.");
    }
  }

  Future adduser({
    @required address,
    @required phone,
    @required pincode,
    @required isShop,
  }) async {
    final fireAuth = FirebaseAuth.instance.currentUser;
    final body = json.encode({
      "address": address,
      "phone": phone,
      "isShop": isShop,
      "pincode": pincode,
    });

    final Uri url = Uri.parse(
      "$api/user/${fireAuth.uid}.json",
    );

    try {
      final result = await http.put(url, body: body);
      await autoLogin();
      if (result.body != null) {
        return false;
      }
      return true;
    } catch (e) {
      throw ("Something went wrong try again.");
    }
  }

  Future autoLogin() async {
    await Firebase.initializeApp();
    final fireAuth = FirebaseAuth.instance.currentUser;

    final Uri url = Uri.parse(
      "$api/user/${fireAuth.uid}.json",
    );
    print(fireAuth.displayName);
    try {
      final result = await http.get(url);
      if (result.body != null) {
        final json = jsonDecode(result.body);

        userData = AppUser.fromJson(json,
            uname: fireAuth.displayName,
            userID: fireAuth.uid,
            imageurl: fireAuth.photoURL);
      }
    } catch (e) {
      print(e);
      throw ("Something went wrong try again.");
    }
  }

// Adding Visit data

  Future addVisit({
    @required data,
  }) async {
    final shopBody = json.encode({
      "name": userData.name,
      "phone": userData.phone,
      "userid": userData.userid,
      "time": DateTime.now().toIso8601String(),
    });
    final userBody = json.encode({
      "name": data["name"],
      "phone": data["phone"],
      "userid": data["userid"],
      "time": DateTime.now().toIso8601String(),
    });

    final Uri userurl = Uri.parse(
      "$api/user/${userData.userid}/visit.json",
    );
    final Uri shopurl = Uri.parse(
      "$api/user/${data["userid"]}/visit.json",
    );

    try {
      await http.post(userurl, body: userBody);
      await http.post(shopurl, body: shopBody);
      userData.visit.add(Myvisit(
        userid: data["userid"],
        id: data["userid"],
        name: data["name"],
        phone: data["phone"].toString(),
        time: DateTime.now().toIso8601String(),
      ));
    } catch (e) {
      print(e);
      throw ("Something went wrong try again.");
    }
  }

  logOut() async {
    await Firebase.initializeApp();
    await FirebaseAuth.instance.signOut();
  }
}
