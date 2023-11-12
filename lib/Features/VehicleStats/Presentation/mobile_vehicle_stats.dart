import 'package:gara/Data/Models/Vehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../Data/Models/gas_stats.dart';
import '../../SharedWidgets/appbar.dart';

class VehicleStatsPage extends StatefulWidget {
  final String vehicleID;
  final Vehicle vehicle;
  final String userId;

  const VehicleStatsPage(
      {Key? key,
      required this.vehicleID,
      required this.vehicle,
      required this.userId})
      : super(key: key);

  @override
  State<VehicleStatsPage> createState() => _VehicleStatsPageState();
}

class _VehicleStatsPageState extends State<VehicleStatsPage> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  late String vehicleId = widget.vehicleID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display vehicle image at the top
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Image.asset(
              widget.vehicle.vehicleImage
                  .toString(), // Replace with your actual image asset path
              height: 200, // Set the desired height
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.vehicle.vehicleName.toString(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Vehicle Stats",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                  'Total Miles: ${widget.vehicle.totalMiles ?? 0}'),
                            ],
                          ))),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                "Gasoline Stats",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          buildFillUps(),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Add Fill Up",
                                        style: TextStyle(color: Colors.green),
                                      )),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "View Trends",
                                        style: TextStyle(color: Colors.green),
                                      )),
                                ],
                              ),
                            ),
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
    );
  }

  Widget buildFillUps() {
    return StreamBuilder(
      stream:
          dbRef.child('/GasStats/${widget.userId}/${widget.vehicleID}').onValue,
      builder: (context, gasSnapshot) {
        if (gasSnapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (gasSnapshot.hasError) {
          return Text('Error: ${gasSnapshot.error}');
        } else {
          return buildFillUpsContent(gasSnapshot);
        }
      },
    );
  }

  Widget buildFillUpsContent(AsyncSnapshot snapshot) {
    final vehicleFillUps = (snapshot.data?.snapshot.value as Map?) ?? {};

    String fillUps = "0";
    String totalCost = "0.00";
    String averageCost = "0.00";

    if (vehicleFillUps.isNotEmpty) {
      fillUps = vehicleFillUps.length.toString();
    }

    vehicleFillUps.forEach((key, value) {
      final gasStats = GasStat.fromRTDB(Map<String, dynamic>.from(value));
      totalCost = (double.parse(totalCost) + gasStats.cost!).toString();
    });

    vehicleFillUps.forEach((key, value) {
      final gasStats = GasStat.fromRTDB(Map<String, dynamic>.from(value));
      averageCost = (double.parse(averageCost) + gasStats.cost!).toString();
    });

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Fill Ups: $fillUps"),
          Text("Total Cost: ${double.parse(totalCost).toString()}"),
          Text("Average Cost: ${double.parse(averageCost).toString()}"),
        ],
      ),
    );
  }
}
