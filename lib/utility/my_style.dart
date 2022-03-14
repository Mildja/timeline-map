import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color.fromARGB(255, 45, 72, 131);
  Color whiteColor = Color.fromARGB(255, 204, 204, 204);
  Color primaryColor = Color.fromARGB(255, 62, 102, 177);
  Color lightColor = Color.fromARGB(255, 169, 231, 247);

  TextStyle darkStyle() => TextStyle(color: darkColor);
  TextStyle blackStyle() => TextStyle(
        color: Colors.black,
        fontSize: 20,
      );
  TextStyle whiteStyle() =>
      TextStyle(color: Color.fromARGB(255, 172, 172, 172));
  TextStyle pinkStyle() => TextStyle(
      color: Color.fromARGB(255, 158, 13, 3),
      fontWeight: FontWeight.w700,
      fontSize: 16);
  TextStyle blackStyle1() => TextStyle(
        color: Colors.black,
        fontSize: 16,
      );

  BoxDecoration boxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white60,
      );

  Widget titleH2(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      );

  Widget showLogo() => Image(
        image: AssetImage('images/user.png'),
      );

  Widget showLogo2() => Image(
        image: AssetImage('images/covid.png'),
      );

  SafeArea buildBackground(double screenWidth, double screenHeight) {
    return SafeArea(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        color: Color.fromARGB(255, 248, 240, 247),
      ),
    );
  }

  MyStyle();
}
