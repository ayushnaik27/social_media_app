import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final Function() onTap;
  const LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isLiked
          ? const Icon(
              color: Colors.redAccent,
              Icons.favorite,
            )
          : const Icon(
              Icons.favorite_border,
              color: Colors.grey,
            ),
    );
  }
}
