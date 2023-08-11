import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/button.dart';
import 'package:social_media_app/widgets/textField.dart';

class LoginPage extends StatefulWidget {
  final Function() onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  // login image
                  Image.asset('lib/images/lock.png', scale: 4),
        
                  const SizedBox(height: 20),
        
                  //Welcome back message
                  const Text('Welcome, good to see you',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  //Email textfield
                  MytextField(
                      controller: _emailTextController,
                      hintText: 'Email',
                      obscureText: false),
        
                  //password textfield
                  MytextField(
                      controller: _passwordTextController,
                      hintText: 'Password',
                      obscureText: true),
        
                  //login button
                  MyButton(
                    text: 'Sign In',
                    onTap: (){},
                  ),
        
                  //row of sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Sign Up now',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),

                  //row for sign in with google,...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
