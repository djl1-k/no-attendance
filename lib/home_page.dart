// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realtime/rent_success.dart';
import 'package:flutter_realtime/swipe_card_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbr = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {

    // Future.delayed(Duration(minutes: 3), () {
    //   // Navigate to another page using Navigator
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => AuthPage(), // Replace YourOtherPage with the actual page you want to navigate to
    //     ),
    //   );
    // });
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: dbr.child('RoomAvailability').onValue, 
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
           if (snapshot.hasData && snapshot.data != null) {
      // Assuming that the 'RoomAvailability' data is boolean
            bool? isRoomAvailable = snapshot.data!.snapshot.value as bool?;

            // Check if the room is available
            if (isRoomAvailable == true && dbr.child('RoomRented') != true)  {
              // Display the list tile when the room is available
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      border: Border.all(
                      color: Colors.grey, // Set the border color
                      width: 1.0, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0), // Add padding as needed
                      title: Text('Room 401'),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Open a dialog when the button is pressed
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                
                                title: Text('Rent Room'),
                                content: SingleChildScrollView(child: Text('Would you like to rent this room?')),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      await dbr.child('RoomRented').set(true);
                                      await dbr.child('RoomAvailability').set(false);
                    
                                      Navigator.of(context).pop(); // Close the dialog
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => RentSuccessPage(), // Replace YourOtherPage with the actual page you want to navigate to
                                        ),);
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Add your logic when the user cancels
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Rent Room'),
                      ),
                    ),
                  ),
                );
            } else {
              // Display an alternative widget when the room is not available
              return Center(
                child: Text(
                  'There are no rooms available at this moment.',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                  )
              );
            }
          } else if (snapshot.hasError) {
            // Handle the error case if necessary
            return Text('Error: ${snapshot.error}');
          } else {
            // Display a loading indicator or any other widget while data is being fetched
            return CircularProgressIndicator();
          }
        }),
    );
  }
}