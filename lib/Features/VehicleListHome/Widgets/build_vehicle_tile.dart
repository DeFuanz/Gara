import 'package:flutter/material.dart';

import '../../VehicleStats/Presentation/mobile_vehicle_stats.dart';
import '../../../Data/Models/Vehicle.dart';

SizedBox buildVehicleTile(
    Vehicle vehicleDetails, BuildContext context, String vehicleID) {
  return SizedBox(
    height: 75,
    width: 350,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VehicleStatsPage(
            vehicleID: vehicleID,
            vehicle: vehicleDetails,
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
