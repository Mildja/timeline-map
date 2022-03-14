import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon.dart';
import 'package:flutter_application_1/mapmain.dart';
import 'package:flutter_application_1/utility/my_style.dart';
import 'package:flutter_application_1/widget/my_signout.dart';
import 'package:flutter_application_1/mapmain.dart';

class SideMenu extends StatefulWidget {
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
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
      
      child: Container( 
          decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                       Color.fromARGB(235, 44, 16, 88),
           Color.fromARGB(235, 55, 14, 73),
              Color.fromARGB(235, 250, 229, 183),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(0),
                    ),
        child: Column(
         
                 
        
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/bottom2.png'), fit: BoxFit.cover)),
              accountEmail: MyStyle().titleH2(email == null ? 'email' : email),
              accountName: MyStyle().titleH2(name == null ? 'Name' : name),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.user),iconColor: Colors.white,
              title: Text('Profile'),textColor: Colors.white ,
              
              onTap: () {
                Navigator.pushReplacementNamed(context, '/Profile');
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),iconColor: Colors.white,
              title: Text('Edit'),textColor: Colors.white ,
              onTap: () {
                Navigator.pushNamed(context, '/ReadSubCollections');
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.plus),iconColor: Colors.white,
              title: Text('AddTimeline'),textColor: Colors.white ,
              onTap: () {
                Navigator.pushNamed(context, '/newadd');
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.locationArrow),iconColor: Colors.white,
              title: Text('showTimeline'),textColor: Colors.white ,
              onTap: () {
                Navigator.pushNamed(context, '/mapmain');
              },
            ),
            Usersignout(),
          ],
        ),
      ),
    );
  }
}
