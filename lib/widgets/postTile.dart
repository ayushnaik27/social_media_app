import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final String message;
  final String email;
  const PostTile({super.key, required this.message, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(email,style: TextStyle(color: Colors.grey.shade500),),
              const SizedBox(height: 10),
              Text(message,maxLines: 4,overflow: TextOverflow.ellipsis,),

          
            ]),
          ),
        ],
      ),
    );
  }
}
