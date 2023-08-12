import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/button.dart';
import 'package:social_media_app/widgets/textField.dart';

class SignupPage extends StatefulWidget {
  final Function() onTap;
  SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //textEditingControllers
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  void signUp() async {
    //show circular indicator
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    //check if passwords match
    if (_passwordTextController.text != _confirmPasswordTextController.text) {
      //stop circular indicator
      Navigator.pop(context);
      //display error
      displayMessage('Passwords don\'t match!!');
      return;
    }
    //try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailTextController.text,
          password: _passwordTextController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      displayMessage(error.message.toString());
    }
  }

  //display a dialog box
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

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
                  const Text('Let\'s create an account',
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

                  //confirm password
                  MytextField(
                      controller: _confirmPasswordTextController,
                      hintText: 'Confirm password',
                      obscureText: true),

                  //login button
                  MyButton(
                    text: 'Sign up',
                    onTap: signUp,
                  ),

                  //row of sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member?'),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Sign In',
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
