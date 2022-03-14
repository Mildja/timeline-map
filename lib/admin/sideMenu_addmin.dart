import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter_application_1/mapmain.dart';
import 'package:flutter_application_1/utility/my_style.dart';
import 'package:flutter_application_1/widget/my_signout.dart';
import 'package:flutter_application_1/mapmain.dart';

class SideMenuAddmin extends StatefulWidget {
  _SideMenuAddminState createState() => _SideMenuAddminState();
}

class _SideMenuAddminState extends State<SideMenuAddmin> {
  @override
  String name = 'null', email = 'null';
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameAnEmail();
  }

  Future<Null> findNameAnEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event!.displayName!;
          email = event.email!;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/heard.jpg'), fit: BoxFit.cover)),
            accountEmail: MyStyle().titleH2(email == null ? 'email' : email),
            accountName: MyStyle().titleH2(name == null ? 'Name' : name),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.user),
            title: Text('main'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/mainAdmain');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.edit),
            title: Text('Edit'),
            onTap: () {
              Navigator.pushNamed(context, '/editAdmin');
            },
          ),
          
          Usersignout(),
        ],
      ),
    );
  }
}
