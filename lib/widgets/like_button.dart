import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final Function() onTap;
  const LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: isLiked
          ? const Icon(
              Icons.favorite,
            )
          : const Icon(Icons.favorite_border),
      color: isLiked? Colors.redAccent : Colors.grey,
    );
  }
}
