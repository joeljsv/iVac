import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacinefinder/provider/centers.dart';
import 'myapp.dart';
import 'provider/locationPro.dart';
import 'utils/apptheme/constant.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) {
  print("Handling a background message: ${message.messageId}");
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print(event);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CenterProvider()),
        ChangeNotifierProvider(create: (context) => LocationProv()),
      ],
      child: MaterialApp(
        title: 'iVac',
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            fontFamily: "Poppins",
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: appPrimaryColor,
              ),
              actionsIconTheme: IconThemeData(
                color: appPrimaryColor,
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(color: appShadow),
            )),
        home: IndexPageStart(),
      ),
    );
  }
}
