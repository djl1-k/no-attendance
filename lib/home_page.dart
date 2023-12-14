// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables


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

    Future.delayed(Duration(seconds: 30), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AuthPage(), // Navigate to auth page after 30 seconds
        ),
      );
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: dbr.onValue, 
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
           if (snapshot.hasData && snapshot.data != null) {

            Map<dynamic, dynamic>? data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

            bool? isRoomAvailable = data?['RoomAvailability'] as bool?;
            int? isRoomRented = data?['RoomRented'] as int?;

            // Check if the room is available
            if (isRoomAvailable == true && isRoomRented == 0)  {
              // Display the list tile when the room is available
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
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
                                        await dbr.child('RoomRented').set(1);
                                        await dbr.child('RoomAvailability').set(false);
                    
                                      Navigator.of(context).pop(); // Close the dialog
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => RentSuccessPage(), // Navigate to rent success page
                                        ),);
                                    },
                                    child: Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text('No'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                    child: ListView(
                      children: [Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          border: Border.all(
                          color: Colors.grey, 
                          width: 1.0, 
                          ),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0), 
                          title: Text('Room 401'),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [Text("Available from 1:00 - 3:30", style: TextStyle(fontSize: 17),)],
                              ),
                          )
                        ),
                      ),]
                    ),
                  ),
                );
            } else {
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
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        }),
    );
  }
}