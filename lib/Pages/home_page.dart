import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'add_vehicle_page.dart';
import '../Data/Models/Vehicle.dart';
import '../Data/Models/gas_stats.dart';
import '../SharedWidgets/appbar.dart';
import 'vehicle_stats_page.dart';

class MobileBodyHome extends StatefulWidget {
  const MobileBodyHome({Key? key}) : super(key: key);

  @override
  State<MobileBodyHome> createState() => _MobileBodyHomeState();
}

class _MobileBodyHomeState extends State<MobileBodyHome> {
  final _auth = FirebaseAuth.instance;
  String? userId;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    getCurrenUser();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        appBar: buildAppBar(context),
        body: Container(
          padding: EdgeInsets.only(top: AppBar().preferredSize.height),
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: dbRef.child('/Vehicles/$userId').onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoading();
        } else if (snapshot.hasError) {
          return buildError();
        } else {
          return buildBodyContent(snapshot);
        }
      },
    );
  }

  Widget buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildError() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.green,
      child: const Center(child: Text('Error Loading')),
    );
  }

  Widget buildBodyContent(AsyncSnapshot snapshot) {
    final userVehicles = Map<String, dynamic>.from(
      (snapshot.data! as DatabaseEvent).snapshot.value as Map<Object?, Object?>,
    );

    return Column(
      children: [
        buildGarageStats(userVehicles),
        const SizedBox(height: 15),
        buildVehiclesSection(userVehicles),
      ],
    );
  }

  Widget buildGarageStats(Map<String, dynamic> userVehicles) {
    num totalMiles = 0;

    userVehicles.forEach((key, value) {
      final vehicleDetails = Vehicle.fromRTDB(Map<String, dynamic>.from(value));

      totalMiles += num.parse(vehicleDetails.totalMiles.toString());
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Text(
                'My Garage',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 50,
              child: buildStatContainer(
                Icons.drive_eta,
                'Total Miles',
                totalMiles.toString(),
              ),
            ),
          ],
        ),
        buildGasStatsSection(),
      ],
    );
  }

  Widget buildStatContainer(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.greenAccent.shade100),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              offset: Offset(2, 4), // Shadow position
            ),
          ],
          color: Colors.greenAccent.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGasStatsSection() {
    return StreamBuilder<DatabaseEvent>(
      stream: dbRef.child('/GasStats/$userId').onValue,
      builder: (context, gasSnapshot) {
        print(gasSnapshot.data.toString());
        if (gasSnapshot.connectionState == ConnectionState.waiting) {
          return buildLoading();
        } else if (gasSnapshot.hasError) {
          return buildError();
        } else {
          return buildGasStatsContent(gasSnapshot);
        }
      },
    );
  }

  Widget buildGasStatsContent(AsyncSnapshot gasSnapshot) {
    if (gasSnapshot.hasError || gasSnapshot.data?.snapshot?.value == null) {
      return Center(
        child: Text('No data available'),
      );
    }

    final userGasStats = Map<String, dynamic>.from(
      (gasSnapshot.data! as DatabaseEvent).snapshot.value
          as Map<Object?, Object?>,
    );

    num totalGasSpending = 0;
    num totalGallonsFilled = 0;

    userGasStats.forEach(
      (key, value) {
        final gasFills = Map<String, dynamic>.from(value);

        gasFills.forEach((key, value) {
          final gasStats = GasStat.fromRTDB(Map<String, dynamic>.from(value));

          totalGasSpending += gasStats.cost ?? 0;
          totalGallonsFilled += gasStats.gallonsFilled ?? 0;
        });
      },
    );

    return Row(
      children: [
        Expanded(
          flex: 50,
          child: buildStatContainer(
            Icons.local_gas_station_rounded,
            'Total Gas Spending',
            totalGasSpending.toStringAsFixed(2),
          ),
        ),
        Expanded(
          flex: 50,
          child: buildStatContainer(
            Icons.attach_money,
            'Gallons Filled',
            totalGallonsFilled.toString(),
          ),
        ),
      ],
    );
  }

  Widget buildVehiclesSection(Map<String, dynamic> userVehicles) {
    final vehicleTiles = userVehicles.entries.map((entry) {
      final vehicleID = entry.key;
      final vehicleDetails =
          Vehicle.fromRTDB(Map<String, dynamic>.from(entry.value));
      return buildVehicleTile(vehicleDetails, context, vehicleID, userId!);
    }).toList();

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Vehicles',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      builder: ((context) => const MobileBodyAddVehicle()),
                    ),
                  ),
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
  }

  SizedBox buildVehicleTile(Vehicle vehicleDetails, BuildContext context,
      String vehicleID, String userId) {
    return SizedBox(
      height: 75,
      width: 350,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VehicleStatsPage(
              vehicleID: vehicleID,
              vehicle: vehicleDetails,
              userId: userId,
            ),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Colors.white),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 25,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image(
                      image: AssetImage(vehicleDetails.vehicleImage.toString()),
                    ),
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
                              fontSize: 20,
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
        ),
      ),
    );
  }
}
