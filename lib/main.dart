import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/router.dart';
import 'package:provider/provider.dart';

String initRoute = '/authen';
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        //login
        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .snapshots()
            .listen((event) {
          UserModel model = UserModel.fromMap(event.data());

          switch (model.typeuser) {
            case 'user':
              initRoute = '/IndexUser';
              runApp(MyApp());
              break;
            case 'addmin':
              initRoute = '/IndexAddmin';
              runApp(MyApp());
              break;
            default:
              print('######## no typeuser');
              initRoute = '/authen';
              runApp(MyApp());
              break;
          }
        });
      } else {
        //logout
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initRoute,
      // title: 'Facebook Login',
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
