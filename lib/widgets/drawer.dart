import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/my_listTile.dart';

class MyDrawer extends StatelessWidget {
  final void Function() onProfileTap;
  final void Function() onSignOut;
  const MyDrawer({super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor: Colors.grey.shade900,
      child: Column(children: [
        //header
        const DrawerHeader(
            child: Icon(
          Icons.person,
          color: Colors.white,
          size: 70,
        )),

        //home list tile
        MyListTile(
          icon: Icons.home,
          text: "H O M E",
          onTap: ()=>Navigator.pop(context),
        ),

        //profile list tile
        MyListTile(
          icon: Icons.person,
          text: "P R O F I L E",
          onTap: onProfileTap,
        ),

        //sign out list tile
        MyListTile(
          icon: Icons.person,
          text: "L O G O U T",
          onTap: onSignOut,
        ),
      ]),
    );
  }
}
