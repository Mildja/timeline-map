import 'package:flutter/material.dart';
import 'package:flutter_application_1/getpoints.dart';
import 'package:flutter_application_1/widget/my_signout.dart';

class IndexUser  extends StatefulWidget {
 

  @override
  _IndexUserState  createState() => _IndexUserState();
}

class _IndexUserState extends State<IndexUser > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('TimeLineOnly1')),
      drawer: Drawer(
              child: Usersignout(),
              
            ),
    );
  }
}