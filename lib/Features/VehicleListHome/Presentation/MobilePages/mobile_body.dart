import 'dart:async';
import 'dart:html';

import 'package:choring/Features/AddNewVehicles/Presentation/MobilePages/mobile_body_addvehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:choring/Features/VehicleListHome/Data/Models/Vehicle.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileBodyHome extends StatefulWidget {
  const MobileBodyHome({Key? key}) : super(key: key);

  @override
  State<MobileBodyHome> createState() => _MobileBodyHomeState();
}

class _MobileBodyHomeState extends State<MobileBodyHome> {
  String miles = "0";
  String avgMiles = "0";
  String fillUps = "0";
  String colour = "";
  String image = "assets/images/car.png";
  String? userEmail = "userEmail";
  String? userId;
  final List<Vehicle> _vehicleList = <Vehicle>[];
  Vehicle? dropdownValue;

  late var vehicleFuture;

  //create firebase instance variable and new user object variable
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  //Grabbed logged in user object
  void getCurrenUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        userEmail = loggedInUser!.email;
        userId = loggedInUser!.uid;
        print(user.uid);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  //grab users vehicle objects from db
  Future getVehicles() async {
    try {
      final vehicleSnapshot = await dbRef.child('/Vehicles/$userId').get();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrenUser();
    vehicleFuture = getVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          'GARA',
          style: GoogleFonts.poiretOne(fontWeight: FontWeight.bold),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('assets/images/garage.png'),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('My Garage'),
              tileColor: Colors.green,
              onTap: () {
                null;
              },
            ),
            ListTile(
              title: const Text('Add Vehicle'),
              onTap: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => const MobileBodyAddVehicle(),
                  ),
                )
                    .then((value) {
                  setState(() {
                    _vehicleList.clear();
                    vehicleFuture = getVehicles();
                  });
                });
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                _auth.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: dbRef.child('/Vehicles/$userId').onValue,
        builder: (context, snapshot) {
          final vehicleTiles = <ListTile>[];
          if (snapshot.hasData) {
            final userVehicles = Map<String, dynamic>.from(
                (snapshot.data! as DatabaseEvent).snapshot.value
                    as Map<String, dynamic>);
            userVehicles.forEach((key, value) {
              final vehicleDetails = Map<String, dynamic>.from(value);

              final vehicleTile = ListTile(
                leading: Icon(Icons.car_rental),
                title: Text(vehicleDetails["Name"]),
              );
              vehicleTiles.add(vehicleTile);
            });
            return ListView(
              children: vehicleTiles,
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );

    // FutureBuilder(
    //   future: vehicleFuture,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Container(
    //         height: double.infinity,
    //         width: double.infinity,
    //         color: Colors.white,
    //         child: const Center(child: CircularProgressIndicator()),
    //       );
    //     } else {
    //       return Scaffold(
    //         appBar: AppBar(
    //           elevation: 0,
    //           foregroundColor: Colors.green,
    //           backgroundColor: Colors.white,
    //           title: Text(
    //             'GARA',
    //             style: GoogleFonts.poiretOne(fontWeight: FontWeight.bold),
    //           ),
    //           leading: const Padding(
    //             padding: EdgeInsets.all(10),
    //             child: Image(
    //               image: AssetImage('assets/images/garage.png'),
    //             ),
    //           ),
    //         ),
    //         endDrawer: Drawer(
    //           child: ListView(
    //             children: [
    //               ListTile(
    //                 title: const Text('My Garage'),
    //                 tileColor: Colors.green,
    //                 onTap: () {
    //                   null;
    //                 },
    //               ),
    //               ListTile(
    //                 title: const Text('Add Vehicle'),
    //                 onTap: () {
    //                   Navigator.of(context)
    //                       .push(
    //                     MaterialPageRoute(
    //                       builder: (context) => const MobileBodyAddVehicle(),
    //                     ),
    //                   )
    //                       .then((value) {
    //                     setState(() {
    //                       _vehicleList.clear();
    //                       vehicleFuture = getVehicles();
    //                     });
    //                   });
    //                 },
    //               ),
    //               ListTile(
    //                 title: const Text('Logout'),
    //                 onTap: () {
    //                   _auth.signOut();
    //                   Navigator.popUntil(context, (route) => route.isFirst);
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //         body: ListView.builder(
    //           itemBuilder: (context, index) {
    //             Vehicle vehicle = snapshot.data![index];
    //           },
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
