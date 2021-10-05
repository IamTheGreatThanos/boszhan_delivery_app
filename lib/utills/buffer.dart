import 'package:flutter/material.dart';

Widget buildAppBar(String title) {
  return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 18)),
      brightness: Brightness.light,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      bottomOpacity: 1,
      iconTheme: IconThemeData(color: Colors.black)
  );
}
