
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_advance/UI/splash_screen.dart';
import 'package:flutter_application_advance/commons/config_notification.dart';
import 'package:flutter_application_advance/provider/login_provider.dart';
import 'package:flutter_application_advance/provider/main_provider.dart';
import 'package:flutter_application_advance/provider/outlet_provider.dart';
import 'package:flutter_application_advance/provider/product_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  askPermissionNotification();
  runApp(const MyApps());
}

void askPermissionNotification() async {
  PermissionStatus permissionNotification =
      await Permission.notification.status;
  if (permissionNotification.isGranted) {
    ConfigNotification().initialNotification();
  } else {
    permissionNotification = await Permission.notification.request();
    if (permissionNotification.isGranted) {
      ConfigNotification().initialNotification();
    }
  }
}

class MyApps extends StatelessWidget {
  const MyApps({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OutletProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
          ),
          home: SplashScreen()),
    );
  }
}
