import 'package:flutter/material.dart';
import 'package:flutter_realtime/swipe_card_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(minutes: 1), () {
      // Navigate to another page using Navigator
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AuthPage(), // Replace YourOtherPage with the actual page you want to navigate to
        ),
      );
    });
    
    return Scaffold(
      body: Text('Another page.'),
    );
  }
}