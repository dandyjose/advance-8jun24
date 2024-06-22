import 'package:flutter/material.dart';
import 'package:flutter_application_advance/UI/login_page.dart';
import 'package:flutter_application_advance/UI/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
            'https://coaching.course-net.com/img/logo_course_net_dark.a81c3f77.png'),
      ),
    );
  }

  Future getSession() async {
    var email, username = '';
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    email = _sharedPreferences.getString('email') ?? '-';
    username = _sharedPreferences.getString('username') ?? '-';
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                // email == '-' ? 
                LoginPage() 
                // : MainPage(email, username),
          )),
    );
  }
}
