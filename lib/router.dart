import 'package:flutter/material.dart';
import 'package:flutter_application_1/addmap.dart';
import 'package:flutter_application_1/admin/editAdmin.dart';
import 'package:flutter_application_1/drop/sub_correction.dart';
import 'package:flutter_application_1/getpoints.dart';
import 'package:flutter_application_1/mapmain.dart';
import 'package:flutter_application_1/newadd.dart';
import 'package:flutter_application_1/states/authen.dart';
import 'package:flutter_application_1/states/create_account.dart';
import 'package:flutter_application_1/states/index_addmin.dart';
import 'package:flutter_application_1/states/index_user.dart';
import 'package:flutter_application_1/states/profile.dart';
import 'package:flutter_application_1/states/sideMenu.dart';
import 'package:flutter_application_1/widget/my_signout.dart';

import 'admin/mainAdmin.dart';
import 'admin/sideMenu_addmin.dart';
import 'drop/update.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext) => Authen(),
  '/createAccoun': (BuildContext context) => CreateAccount(),
  '/IndexUser': (BuildContext context) => IndexUser(),
  '/IndexAddmin': (BuildContext context) => IndexAddmin(),
  '/getpoints': (BuildContext context) => GetPoints(),
  //'/addmap': (BuildContext context) => addmap(),
  '/newadd': (BuildContext context) => newadd(),
  '/mapmain': (BuildContext context) => mapmain(),
  // '/DropPage': (BuildContext context) => DropPage(),
  '/updatePage': (BuildContext context) => updatePage(),
  '/ReadSubCollections': (BuildContext context) => ReadSubCollections(),
  '/Profile': (BuildContext context) => Profile(),
  '/Logout': (BuildContext context) => Usersignout(),
  '/SideMenu': (BuildContext context) => SideMenu(),
  '/SideMenuAddmin': (BuildContext context) => SideMenuAddmin(),
  '/mainAdmin': (BuildContext context) => mainAdmin(),
  '/editAdmin': (BuildContext context) => editAdmin(),
};
