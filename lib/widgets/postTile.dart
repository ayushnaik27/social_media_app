import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/like_button.dart';

class PostTile extends StatefulWidget {
  final String message;
  final String email;
  final String postId;
  final List<String> likes;
  const PostTile(
      {super.key,
      required this.message,
      required this.email,
      required this.postId,
      required this.likes});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.likes.contains(currentUser.email);
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //get document in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("User Posts").doc(widget.postId);

    
    if (isLiked) {
      //if user liked add users email to like list
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //if disliked remove user from liked list
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Column(
            children: [
              //likeButton
              LikeButton(isLiked: isLiked, onTap: toggleLike),

              //likeCount
              Text(widget.likes.length.toString()),
            ],
          ),
          const SizedBox(width: 10),
          Flexible(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.email,
                style: TextStyle(color: Colors.grey.shade500),
              ),
              const SizedBox(height: 10),
              Text(
                widget.message,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
