import 'package:choring/Features/VehicleListHome/Data/Models/Vehicle.dart';
import 'package:flutter/material.dart';

class VehicleStatsPage extends StatefulWidget {
  final String vehicleID;
  final Vehicle vehicle;

  const VehicleStatsPage(
      {Key? key, required this.vehicleID, required this.vehicle})
      : super(key: key);

  @override
  State<VehicleStatsPage> createState() => _VehicleStatsPageState();
}

class _VehicleStatsPageState extends State<VehicleStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [Text(widget.vehicle.vehicleName.toString())],
            ),
          ],
        ),
      ),
    );
  }
}
