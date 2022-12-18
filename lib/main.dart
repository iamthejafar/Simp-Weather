import 'package:flutter/material.dart';
import 'front_page.dart';
void main(){
  return runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff06061f),
        body: FrontPage(),
      ),
    )
  );
}
