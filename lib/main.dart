import 'package:flutter/material.dart';
import 'package:social_media_app/auth/login_or_signUp.dart';

import 'pages/loginPage.dart';
import 'pages/signupPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrSignup(),
    );
  }
}
