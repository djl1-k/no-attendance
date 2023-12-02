// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_realtime/home_page.dart';
import 'package:flutter_realtime/invalid_card.dart';



class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final dbr = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            "Scan your card",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
              stream: dbr.child('authStatus').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  // Assuming authStatus is a boolean
                  bool? authStatus = snapshot.data!.snapshot.value as bool?;

                  if (authStatus == true) {
                    // Navigate to another page if authStatus is true
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }
                  else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => InvalidCardPage(),
                      )
                    );
                  }
                  // You can add an else block if you want to handle false case
                }
              return SizedBox.shrink();
              },

              
          ),
        ],
        )
      ),
    );
  }
}