import 'package:flutter/material.dart';
import 'package:social_media_app/pages/loginPage.dart';
import 'package:social_media_app/pages/signupPage.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {

  bool showLoginPage= true;

  void togglePages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage ? LoginPage(onTap: togglePages): SignupPage(onTap: togglePages);
  }
}