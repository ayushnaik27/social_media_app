import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String commentText;
  final String user;
  final String time;
  const Comment(
      {super.key,
      required this.commentText,
      required this.user,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //comment
        Text(commentText),
        //user, time
        Row(
          children: [
            Text(
              user,
              style: TextStyle(color: Colors.grey.shade400),
            ),
            const Text(
              " · ",
              style: TextStyle(color: Colors.grey),
            ),
            Text(time, style: TextStyle(color: Colors.grey.shade400))
          ],
        ),
      ]),
    );
  }
}
