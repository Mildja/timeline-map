import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/mainAdmin.dart';
import 'package:flutter_application_1/drop/sub_correction.dart';
import 'package:flutter_application_1/getpoints.dart';
import 'package:flutter_application_1/addmap.dart';
import 'package:flutter_application_1/mapmain.dart';
import 'package:flutter_application_1/newadd.dart';
import 'package:flutter_application_1/states/dialog.dart';
import 'package:flutter_application_1/utility/my_style.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

import '../blocs/auth_bloc.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screenWidth = 0, screenHeight = 0;
  bool redEye = false;
  double screen = 0;
  String user = 'null', password = 'null';
  String typeUser = 'null', name = 'null', email = 'null', uid = 'null';

  // void initState() {
  //   var authBloc = Provider.of<AuthBloc>(context, listen: false);
  //   authBloc.currentUser.liten((fbUser) {
  //     if (fbUser != null) {
  //       Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => mapmain()));
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      floatingActionButton: buildCreateAccount(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.4 - 27,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login1.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            //     Container(
            //  height: size.height*0.4-27,
            //  decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,

            //   colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 10, 174, 250),Color.fromARGB(255, 30, 90, 255),]),
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(30),
            //   bottomRight: Radius.circular(30),
            // ),
            // ),
            //     ),
            Positioned(
                bottom: 0,
                left: 10,
                right: 10,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 480,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                      Text(
                        'LOGIN',
                        style: MyStyle().blackStyle(),
                      ),
                      buildUser(),
                      buildPassword(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row( mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildlogin1(), admin(),
                          ],
                        ),
                      ),
                     
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      buildlogin()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildlogin1() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 50,
      child: FloatingActionButton(
        onPressed: () {
          if ((user.isEmpty) || (password.isEmpty)) {
          } else {
            checkAuthen();
          }
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Color.fromARGB(255, 69, 70, 71),
      ),
    );
  }

  Container admin() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 50,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                /*context, MaterialPageRoute(builder: (context) => mapmain()));*/
                context, MaterialPageRoute(builder: (context) => mainAdmin())); 
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 122, 97, 134),
      ),
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
        ),
        Text(
          'CREATE ACCOUNT ?',
          style: MyStyle().blackStyle1(),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/createAccoun'),
          child: Text('Create Account', style: MyStyle().darkStyle()),
        ),
      ],
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.6,
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(20))),
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'User:',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screenWidth * 0.6,
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(20))),
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: !redEye,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              redEye
                  ? Icons.remove_red_eye_outlined
                  : Icons.remove_red_eye_sharp,
              color: MyStyle().darkColor,
            ),
            onPressed: () {
              setState(() {
                redEye = !redEye;
              });
            },
          ),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
          labelStyle: MyStyle().darkStyle(),
          labelText: 'Password:',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().darkColor)),
        ),
      ),
    );
  }

  Row buildlogin() {
    // var authBloc = Provider.of<AuthBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //grust
        FloatingActionButton(
          onPressed: () {
            Navigator.push(
                /*context, MaterialPageRoute(builder: (context) => mapmain()));*/
                context, MaterialPageRoute(builder: (context) => GetPoints()));  
          },
          child: Icon(Icons.perm_identity),
          backgroundColor: Color.fromARGB(255, 69, 70, 71),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            // onPressed: () => authBloc.loginFacebook(),
              onPressed: () {},
            child: Icon(Icons.facebook),
            backgroundColor: Colors.blue,
          ),
        ),

        FloatingActionButton(
          onPressed: () => processSingInWithGoogle(),
          child: Text(
            'g+',
            style: MyStyle().whiteStyle(),
            textScaleFactor: 1.5,
           
          ),
          backgroundColor: Color.fromARGB(255, 214, 31, 18),
        ),
      ],
    );
  }

  Future<Null> processSingInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    await Firebase.initializeApp().then((value) async {
      await _googleSignIn.signIn().then((value) async {
        name = value!.displayName!;
        email = value.email;
        print('Login with gmail Succes name = $name,email = $email');
        await value.authentication.then((value2) async {
          AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: value2.idToken,
            accessToken: value2.accessToken,
          );
          await FirebaseAuth.instance
              .signInWithCredential(authCredential)
              .then((value3) async {
            uid = value3.user!.uid;
            print(
                'Login with gmail Succes name = $name,email = $email,uid = $uid');
            await FirebaseFirestore.instance
                .collection('user')
                .doc(uid)
                .snapshots()
                .listen((event) {
              print('event ==> ${event.data()}');
              if (event.data() == null) {
                //call type
                print(
                    'call type User, name = $name, email = $email, uid= $uid');
              } else {
                //Route to Service by TypeUser
                print('Route to service');
              }
            });
          });
        });
      });
    });
  }

  Future<Null> callTypeUserDialog() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: MyStyle().showLogo(),
          title: Text('Type User?'),
          subtitle: Text('Please Choose Type User'),
        ),
        children: [
          RadioListTile(
            value: 'user',
            groupValue: typeUser,
            onChanged: (value) {},
            title: Text('User'),
          ),
          RadioListTile(
            value: 'addmin',
            groupValue: typeUser,
            onChanged: (value) {},
            title: Text('Addmin'),
          ),
          TextButton(onPressed: () {}, child: Text('OK')),
        ],
      ),
    );
  }

  Container buildlogo() {
    return Container(
      width: 80,
      child: MyStyle().showLogo(),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/mapmain', (route) => false));

     //void login() async {
//         final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//         firebaseAuth
//             .signInWithEmailAndPassword(
//                 email: emailController.text, password: passwordController.text)
//             .then((result) {
//           {
//             Navigator.pushReplacementNamed(context, '/homepage');
//           }
//         }).catchError((err) {

//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text("Error"),
//                   content: Text(err.message),
//                   actions: [
//                     FlatButton(
//                       child: Text("Ok"),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     )
//                   ],
//                 );
//               });
//         });
//       }
              
    });
  }
}
