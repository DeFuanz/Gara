import 'package:choring/Features/AddNewVehicles/Presentation/MobilePages/mobile_body_addvehicle.dart';
import 'package:choring/Features/VehicleListHome/Data/Models/Vehicle.dart';
import 'package:choring/Features/VehicleStats/Presentation/mobile_vehicle_stats.dart';
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
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  //Initialize State
  @override
  void initState() {
    getCurrenUser();
    super.initState();
  }

  //Build Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.green,
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.grey,
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: dbRef.child('/Vehicles/$userId').onValue,
        builder: (context, snapshot) {
          final vehicleTiles = <SizedBox>[];
          num totalMiles = 0;
          num avgMiles = 0;
          num totalGasSpending = 0;
          num avgGasSpending = 0;

          if (snapshot.hasData) {
            final userVehicles = Map<String, dynamic>.from(
                (snapshot.data! as DatabaseEvent).snapshot.value
                    as Map<Object?, Object?>);
            userVehicles.forEach((key, value) {
              final vehicleID = key;
              final vehicleDetails =
                  Vehicle.fromRTDB(Map<String, dynamic>.from(value));

              for (int i = 0; i < userVehicles.length; i++) {
                totalMiles += num.parse(vehicleDetails.totalMiles.toString());
                avgMiles = totalMiles / userVehicles.length;
              }

              final vehicleTile = SizedBox(
                height: 75,
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.white)),
                    color: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image(
                                  image: AssetImage(
                                      vehicleDetails.vehicleImage.toString())),
                            ),
                          ),
                          Expanded(
                            flex: 60,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 60,
                                  child: Center(
                                    child: Text(
                                      vehicleDetails.vehicleName.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 40,
                                  child: Text(
                                      'Total Miles: ${vehicleDetails.totalMiles.toString()}'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  iconSize: 35,
                                  icon: const Icon(Icons.remove_red_eye,
                                      color: Colors.green),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => VehicleStatsPage(
                                        vehicleID: vehicleID,
                                      ),
                                    ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
              vehicleTiles.add(vehicleTile);
            });

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 50,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: const [
                              Text(
                                'My Garage',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(
                                                    2, 4), // Shadow position
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.drive_eta),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Total Miles',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    totalMiles.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 25),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(
                                                    2, 4), // Shadow position
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.add_road_outlined),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Average Miles',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(avgMiles.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 25)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(
                                                    2, 4), // Shadow position
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons
                                                      .local_gas_station_rounded),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Total Gas Spending',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      totalGasSpending
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 25)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 8,
                                                offset: Offset(
                                                    2, 4), // Shadow position
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.attach_money),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Avg. Gas Spending',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      avgGasSpending.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 25)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Vehicles',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.add_box_outlined,
                            size: 40,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const MobileBodyAddVehicle()))),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 4),
                      children: vehicleTiles,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.green,
              child: const Center(child: Text('Error Loading')),
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
