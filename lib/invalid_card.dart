// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_realtime/swipe_card_page.dart';

class InvalidCardPage extends StatelessWidget {
  const InvalidCardPage({super.key});

   
  @override
  Widget build(BuildContext context) {

     Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AuthPage(), // Navigate to auth page after 3 seconds
            ),
          );
        });
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            'Invalid Card',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )]
      )),
    );
  }
}