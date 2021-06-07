import 'package:flutter/material.dart';
import 'package:flutter_study/user_edit.dart';
import 'package:get/get.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
 //     getPages: [
//        GetPage(name: "/", page: ()=>Home(),transition: Transition.leftToRight),
//        GetPage(name: "/edit_page", page: ()=>UserEdit(),transition: Transition.leftToRight),
//      ],
    );
  }
}
