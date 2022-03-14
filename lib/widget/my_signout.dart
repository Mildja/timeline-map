import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Usersignout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
            onTap: () async {
              await Firebase.initializeApp().then((value) async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/authen', (route) => false));
              });
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 24,
            ),
            title: Text(
              'Signout',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            tileColor: Colors.red),
      ],
    );
  }
}
