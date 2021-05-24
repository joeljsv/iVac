import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/models/user/user.dart';
import 'package:vacinefinder/myapp.dart';
import 'package:vacinefinder/provider/user.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppUser user = Provider.of<UserProvider>(context, listen: false).user;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(user.imageUrl),
            ),
          ),
          Text(
            "${user.name}",
            style: kHeadingTextStyle.copyWith(fontSize: 26),
          ),
          Text(
            "Pincode: ${user.pincode}",
            style: kHeadingTextStyle,
          ),
          Text(
            "Phone: ${user.phone}",
            style: kHeadingTextStyle,
          ),
          Text(
            "Addres\n${user.address}",
            textAlign: TextAlign.center,
            style: kHeadingTextStyle,
          ),
          if (user.isShop)
            Text(
              "\nLoged in as Shop",
              style: kHeadingTextStyle.copyWith(
                  fontSize: 35, fontWeight: FontWeight.bold),
            ),
          TextButton(
            onPressed: () async {
              await Provider.of<UserProvider>(context, listen: false).logOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => IndexPageStart(),
                ),
              );
            },
            child: Text(
              "Logout",
              textAlign: TextAlign.center,
              style: kHeadingTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
