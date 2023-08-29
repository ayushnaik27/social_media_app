import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/helper/helper_methods.dart';
import 'package:social_media_app/widgets/comment.dart';
import 'package:social_media_app/widgets/comment_button.dart';
import 'package:social_media_app/widgets/like_button.dart';

class PostTile extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;
  const PostTile(
      {super.key,
      required this.message,
      required this.postId,
      required this.likes,
      required this.user,
      required this.time});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final TextEditingController commentTextController = TextEditingController();
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

  //add comment
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": formatDate(Timestamp.now()),
    });
  }

  //comment ke liye dialog
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add comment'),
              content: TextField(
                controller: commentTextController,
                decoration: const InputDecoration(hintText: "Write a comment"),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    //add comment to firestore
                    addComment(commentTextController.text);
                    //pop the dialog box
                    Navigator.pop(context);
                    //clear controller
                    commentTextController.clear();
                  },
                  child: const Text("Post"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.user,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const SizedBox(height: 10),
            Text(
              widget.message,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  //likeButton
                  LikeButton(isLiked: isLiked, onTap: toggleLike),

                  const SizedBox(height: 5),

                  //likeCount
                  Text(widget.likes.length.toString()),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  //likeButton
                  CommentButton(onTap: showCommentDialog),
                  const SizedBox(height: 5),

                  //likeCount
                  const Text("0"),
                ],
              ),
            ],
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("comments")
                  .orderBy("CommentTime", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  shrinkWrap: true, //nested lists ke liye
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((e) {
                    //get the comment
                    final commentData = e.data();

                    //return comment
                    return Comment(
                        commentText: commentData["CommentText"],
                        user: commentData["CommentedBy"],
                        time: commentData["CommentTime"]);
                  }).toList(),
                );
              }),
        ],
      ), //sabse bahar wala
    );
  }
}
