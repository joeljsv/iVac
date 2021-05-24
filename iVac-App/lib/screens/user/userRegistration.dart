import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/provider/user.dart';
import 'package:vacinefinder/screens/vacine/home.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';
import 'package:vacinefinder/utils/loading.dart';
import 'package:vacinefinder/widgets/user/userform.dart';

import '../homeMain.dart';

class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

TextStyle style = TextStyle(fontSize: 14);

InputBorder border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(50),
  borderSide: BorderSide(
    width: 2,
    style: BorderStyle.none,
  ),
);

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController phnNumberController = TextEditingController();

  bool _isUser = true;

// isUser
  user() {
    setState(() {
      _isUser = !_isUser;
    });
    print(_isUser);
  }

  // Post
  signIn() async {
    try {
      
      await Provider.of<UserProvider>(context, listen: false).adduser(
          address: place.text,
          phone: phnNumberController.text,
          pincode: pincodeController.text,
          isShop: !_isUser);
      
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => MainHomeScreen(),
          ),
        );
    } catch (e) {
      Navigator.pop(context);
      popUpwithButton(context,
          title: "Oops!", body: "An Error occured try agaoin!.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: UserForm(
              user: user,
              isuser: _isUser,
              sign: signIn,
              formKey: _formKey,
              phnNumberController: phnNumberController,
              pincodeController: pincodeController,
              place: place,
            ),
          ),
        ),
      ),
    );
  }
}
