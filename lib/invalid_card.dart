// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class InvalidCardPage extends StatelessWidget {
  const InvalidCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            'Invalid Card.',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            )]
      )),
    );
  }
}