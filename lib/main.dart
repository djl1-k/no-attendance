// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_realtime/firebase_options.dart';
import 'package:flutter_realtime/rent_success.dart';
import 'package:flutter_realtime/swipe_card_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RentSuccessPage(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int lightStatus = 1;
  final dbr = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutterfire'), backgroundColor: Colors.blue,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            lightStatus == 1?Icon(Icons.abc_rounded, size: 70, color: Colors.amber,):Icon(Icons.abc_sharp, size: 70,),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  lightStatus = lightStatus == 1 ? 0 : 1;
                  dbr.child("Light").set({"Switch": lightStatus});
                });
              }, 
              child: lightStatus == 1?Text('LED On'): Text('LED Off'))
          ],
        ),
      ),

    );
  }
}
