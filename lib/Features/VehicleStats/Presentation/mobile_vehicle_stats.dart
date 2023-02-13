import 'package:flutter/material.dart';

class VehicleStatsPage extends StatefulWidget {
  final String vehicleID;

  const VehicleStatsPage({Key? key, required this.vehicleID}) : super(key: key);

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
        child: Center(
          child: Text(widget.vehicleID),
        ),
      ),
    );
  }
}
