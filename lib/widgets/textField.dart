import 'package:flutter/material.dart';

class MytextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MytextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        cursorColor: Colors.black12,
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
