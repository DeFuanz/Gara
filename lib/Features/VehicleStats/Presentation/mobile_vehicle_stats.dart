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
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () => null,
          //   ),
          // ],
          ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display vehicle image at the top
            Image.asset(
              widget.vehicle.vehicleImage
                  .toString(), // Replace with your actual image asset path
              height: 200, // Set the desired height
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vehicle Name: ${widget.vehicle.vehicleName ?? ""}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Average Miles: ${widget.vehicle.avgMiles ?? 0}'),
                  Text('Fill Ups: ${widget.vehicle.fillUps ?? 0}'),
                  Text('Total Miles: ${widget.vehicle.totalMiles ?? 0}'),
                  Text('Color: ${widget.vehicle.color ?? ""}'),
                  Text('Vehicle Type: ${widget.vehicle.vehicleType ?? ""}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
