// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_realtime/swipe_card_page.dart';

class RentSuccessPage extends StatelessWidget {
  const RentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AuthPage(), // navigate to auth page after 3 seconds
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rent Successful',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            Text('Will return to authentication page soon.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
          ]
        )
        )
    );
  }
}