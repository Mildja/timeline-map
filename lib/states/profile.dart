// ignore_for_file: deprecated_member_use

import 'package:flutter/src/widgets/icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/sideMenu.dart';
import 'package:flutter_application_1/utility/my_style.dart';
import 'package:flutter_application_1/widget/my_signout.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String displayName = 'null';
  String name = 'null', email = 'null';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findDisplayName();
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

  Future<Null> findDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          displayName = event!.displayName!;
        });
        print('#### displayName = $displayName');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 205, 209),
      appBar: AppBar(title: Text('Profile'),
       flexibleSpace: Container(
       decoration: new BoxDecoration(
         gradient:  new LinearGradient(colors: [
           Color.fromARGB(235, 44, 16, 88),
           Color.fromARGB(235, 243, 177, 223),
         ],begin: const FractionalOffset(0.0, 0.0),
         end:const FractionalOffset(1.0, 0.0) ,
         stops: [0.0,1.0],
         tileMode: TileMode.clamp)
       ),
     ),),
      drawer: SideMenu(),
      // drawer: Drawer(
      //     child: Stack(
      //   children: [
      //     UserAccountsDrawerHeader(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage('images/heard.jpg'), fit: BoxFit.cover),
      //       ),
      //       accountEmail: MyStyle().titleH2(email == null ? 'email' : email),
      //       accountName: MyStyle().titleH2(name == null ? 'Name' : name),
      //     ),
      //     Usersignout(),
      //   ],
      // )),

      body: SafeArea(
        
        child: Stack(
          children: [
             Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                
                child: Container(
                
                  height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 255, 255, 255),
                        Color.fromARGB(255, 223, 222, 222),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                )),
            
            // MyStyle().buildBackground(screenWidth, screenHeight),
            Center(
              
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   buildlogo(),
                  Container(
                    width: 300,
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          print('You Click');
                          editThread();
                        },
                      ),
                      title: Text(displayName == null ? 'Non ?' : displayName),
                      subtitle: Text('Display Name User'),
                    ),
                  ),
                  buildemaill(),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Container buildemaill() {
    return Container(
      width: 300,
      child: ListTile(
        trailing: IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {
            print('You Click');
            editThread1();
          },
        ),
        title: Text(email == null ? 'Non ?' : email),
        subtitle: Text('Display Email'),
      ),
    );
  }

  Container buildlogo() {
    return Container(
      width: 80,
      child: MyStyle().showLogo(),
    );
  }

  Future<Null> editThread() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: MyStyle().showLogo(),
          title: Text('Edit DisplayName'),
          subtitle: Text('Please Fill New Display in Blank'),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: MyStyle().boxDecoration(),
                width: 200,
                child: TextFormField(
                  onChanged: (value) => displayName = value.trim(),
                  initialValue: displayName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  print('current displayName =$displayName');
                  await Firebase.initializeApp().then((value) async {
                    await FirebaseAuth.instance
                        .authStateChanges()
                        .listen((event) async {
                      event!.updateDisplayName(displayName).then((value) {
                        findDisplayName();
                        Navigator.pop(context);
                      });
                    });
                  });
                },
                child: Text('Edit DisplayName'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cencle',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<Null> editThread1() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: MyStyle().showLogo(),
          title: Text('Edit Emaill'),
          subtitle: Text('Please Fill New Display in Blank'),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: MyStyle().boxDecoration(),
                width: 200,
                child: TextFormField(
                  onChanged: (value) => email = value.trim(),
                  initialValue: email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  print('current email =$email');
                  await Firebase.initializeApp().then((value) async {
                    await FirebaseAuth.instance
                        .authStateChanges()
                        .listen((event) async {
                      event!.updateEmail(email).then((value) {
                        findNameAnEmail();
                        Navigator.pop(context);
                      });
                    });
                  });
                },
                child: Text('Edit Emaill'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cencle',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  updateDisplayName({required String displayName}) {}
  updateEmail({required String email}) {}
}
