import 'package:flutter/material.dart';
import 'package:vacinefinder/screens/user/userRegistration.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';

class UserForm extends StatelessWidget {
  const UserForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.phnNumberController,
    @required this.pincodeController,
    @required this.place,
    @required bool isuser,
    this.sign,
    this.user,
  })  : _formKey = formKey,
        _isUser = isuser,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController phnNumberController;
  final TextEditingController pincodeController;
  final TextEditingController place;

  final Function sign;
  final bool _isUser;
  final Function user;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/icon.png',
                        fit: BoxFit.fitHeight,
                        height: 70,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 4,
                  // ),
                  Text(
                    'iVac',
                    style: kHeadingTextStyle,
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            TextFormField(
              maxLength: 10,
              autofillHints: [AutofillHints.telephoneNumberDevice],
              validator: (val) {
                if (val.isEmpty) {
                  return 'Phone number is required';
                } else if (val.length < 10 || val.length < 10) {
                  return 'Phone Number must be 10 digits';
                } else {
                  return null;
                }
              },
              controller: phnNumberController,
              // onChanged: (value) {
              //   this.phoneNo = value;
              // },
              keyboardType: TextInputType.phone,
              style: style,
              decoration: InputDecoration(
                border: border,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: introBackgroundColor,
                      ),
                      Text('+91')
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Enter Your Phone number",
                labelText: 'Phone number',
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              maxLength: 6,
              autofillHints: [AutofillHints.postalCode],
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Pincode is required';
                } else if (val.length != 6) {
                  return "Enter valid Pincode";
                } else {
                  return null;
                }
              },
              textCapitalization: TextCapitalization.words,
              controller: pincodeController,
              style: style,
              decoration: InputDecoration(
                border: border,
                prefixIcon: Icon(
                  Icons.location_on,
                  color: introBackgroundColor,
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Enter Your Pincode",
                labelText: 'Pincode',
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 24),
            TextFormField(
              maxLines: 3,
              minLines: 2,
              autofillHints: [AutofillHints.postalAddress],
              textCapitalization: TextCapitalization.words,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Address is required';
                } else {
                  return null;
                }
              },
              controller: place,
              style: style,
              decoration: InputDecoration(
                border: border,
                prefixIcon: Icon(
                  Icons.location_city,
                  color: introBackgroundColor,
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Enter Address",
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(value: !_isUser, onChanged: (val) => user()),
                Text(
                  "Sign Up as Shop",
                  style: kHeadingTextStyle,
                )
              ],
            ),
            SizedBox(height: 24),
            Container(
              width: 150,
              height: 45,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(appPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                // elevation: 3,
                // color: AppTheme.appColor.primary,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(50),
                // ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState.validate()) {
                    sign();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 17,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
