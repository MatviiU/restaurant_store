import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internetmarket/DataBases/DBConnect.dart';
import 'package:internetmarket/FireBaseConnect.dart';
import 'package:internetmarket/Windows/loginWindow.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FireBaseConnect().database;
  }
  else{
    await DBConnect.db;
  }
  runApp(const MyApp());

}
late bool isBigScreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    isBigScreen = MediaQuery.of(context).size.width >= 500;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginWindow(),
    );
  }
}
