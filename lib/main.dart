import 'dart:collection';
import 'dart:developer';
import 'dart:math';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:mailapp4232020/dbms.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'settings.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  ///This ensures the database is initialized before starting the program.
  ///If a user has not been created they are sent to the login screen otherwise,
  ///they are directed to the home screen.
  WidgetsFlutterBinding.ensureInitialized();
  final dbms = DBMS.dbms;
  var list = await dbms.queryUserData();
  var buckets = await dbms.queryAllBuckets();
  int numberOfBuckets = buckets.length;
  print('list length: ${list.length}');
  list.forEach((item) => print(item));
  bool userExists = (list.length > 1);
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(verified: userExists, user: list, initialBuckets: numberOfBuckets,));
}
///MyApp class uses information from the database to initialize the program.
class MyApp extends StatelessWidget {
  MyApp({Key key, this.verified = false, this.user, this.initialBuckets}) : super(key: key);

  final int initialBuckets;
  final bool verified;
  final List<String> user;
  static final dbms = DBMS.dbms;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rowan Email Filtration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _startPoint(),
    );
  }
   _startPoint() {
    if(verified){
      return HomePage(user[0],user[1]);
    }else{
      return LoginPage(title: 'Rowan Email Filtration');
    }
  }
}









