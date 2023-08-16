import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all Users
  final userCollection = FirebaseFirestore.instance.collection("Users");

  //edit Field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: Text(
                'Edit $field',
                style: const TextStyle(color: Colors.white),
              ),
              content: TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: const TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                //cancel button
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel')),

                // save button
                TextButton(
                    onPressed: () => Navigator.pop(context, newValue),
                    child: const Text('save')),
              ],
            ));

    //update in firestore
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.email).update({
        field: newValue,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Your Profile',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;

                return ListView(
                  children: [
                    const SizedBox(height: 50),
                    //prifile picture
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),

                    //email
                    Text(currentUser.email.toString(),
                        textAlign: TextAlign.center),

                    //user details
                    const SizedBox(height: 50),

                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'My Details',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    //username
                    MyTextBox(
                      sectionName: 'username',
                      text: userData['username'],
                      onTap: () => editField('username'),
                    ),

                    //bio
                    MyTextBox(
                      sectionName: 'bio',
                      text: userData['bio'],
                      onTap: () => editField('bio'),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
