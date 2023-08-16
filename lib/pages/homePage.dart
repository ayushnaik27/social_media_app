import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '/widgets/drawer.dart';
import '/widgets/postTile.dart';
import 'profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postTextController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    if (_postTextController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'email': currentUser.email,
        'message': _postTextController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [] 
      });
      //clear textController
      _postTextController.clear();
    }
  }

  void goToProfile(){
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ProfilePage()));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: goToProfile,
        onSignOut: signOut,
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Socials',style: TextStyle(fontSize: 25),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            //the posts
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy("TimeStamp",descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return PostTile(
                        email: post['email'],
                        message: post['message'],
                        postId: post.id,
                        likes: List<String>.from(post['Likes']?? []),
                        
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Text('Bhai kya kr rha hai');
                }
              },
            )),

            //post textfield
            Padding(
              padding: const EdgeInsets.only(right: 25,left: 25,bottom: 25,top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: false,
                      
                      controller: _postTextController,
                      decoration: const InputDecoration(
                        hintText: 'Enter a message to post',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_circle_up))
                ],
              ),
            ),
            Text('Logged in as ${currentUser.email}'),
          ],
        ),
      ),
    );
  }
}
