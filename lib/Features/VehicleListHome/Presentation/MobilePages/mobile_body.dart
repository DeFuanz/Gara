import 'package:choring/Features/AddNewVehicles/Presentation/MobilePages/mobile_body_addvehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileBodyHome extends StatefulWidget {
  const MobileBodyHome({Key? key}) : super(key: key);

  @override
  State<MobileBodyHome> createState() => _MobileBodyHomeState();
}

class _MobileBodyHomeState extends State<MobileBodyHome> {
  //Defualt Values for
  String miles = "0";
  String avgMiles = "0";
  String fillUps = "0";
  String colour = "";
  String image = "assets/images/car.png";

  //create firebase instance variable and new user object variable
  final _auth = FirebaseAuth.instance;
  String? userId;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  //Grabbed logged in user object
  void getCurrenUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        userId = user.uid;
        print(user.uid);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrenUser();
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MobileBodyAddVehicle(),
                  ),
                );
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
          final vehicleTiles = <SizedBox>[];
          if (snapshot.hasData) {
            final userVehicles = Map<String, dynamic>.from(
                (snapshot.data! as DatabaseEvent).snapshot.value
                    as Map<Object?, Object?>);
            userVehicles.forEach((key, value) {
              final vehicleDetails = Map<String, dynamic>.from(value);

              final vehicleTile = SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.green)),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 33,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image(
                                image: AssetImage(vehicleDetails["Image"])),
                          ),
                        ),
                        Expanded(
                          flex: 66,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 50,
                                child: Center(
                                  child: Text(
                                    vehicleDetails["Name"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 20,
                                child: Text(
                                    'Total Miles: ${vehicleDetails["Miles"].toString()}'),
                              ),
                              Expanded(
                                flex: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      child: IconButton(
                                        icon: const Icon(
                                            Icons.local_gas_station_rounded),
                                        onPressed: () {
                                          null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      color: Colors.green,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              vehicleTiles.add(vehicleTile);
            });

            return ListView(
              padding: const EdgeInsets.only(bottom: 4),
              children: vehicleTiles,
            );
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.green,
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
  }
}
