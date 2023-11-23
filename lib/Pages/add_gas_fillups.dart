import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddGasFillUps extends StatefulWidget {
  final String vehicleID;
  final String userId;

  const AddGasFillUps({Key? key, required this.vehicleID, required this.userId})
      : super(key: key);

  @override
  State<AddGasFillUps> createState() => _AddGasFillUpsState();
}

class _AddGasFillUpsState extends State<AddGasFillUps> {
  final _dbRef = FirebaseDatabase.instance.ref();

  TextEditingController costController = TextEditingController();
  TextEditingController milesController = TextEditingController();
  TextEditingController gallonsController = TextEditingController();

  void addGasFillUp(String userId, String vehicleId) {
    num cost = double.tryParse(costController.text) ?? 0.0;
    num milesSinceLastFill = double.tryParse(milesController.text) ?? 0.0;
    num gallonsFilled = double.tryParse(gallonsController.text) ?? 0.0;

    Map<String, dynamic> fillUpData = {
      'Cost': cost,
      'MilesSinceLastFill': milesSinceLastFill,
      'GallonsFilled': gallonsFilled,
    };

    _dbRef
        .child('GasStats')
        .child(userId)
        .child(vehicleId)
        .push()
        .set(fillUpData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gas Fill-Ups'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: costController,
              decoration: const InputDecoration(labelText: 'Cost'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: milesController,
              decoration:
                  const InputDecoration(labelText: 'Miles Since Last Fill'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: gallonsController,
              decoration: const InputDecoration(labelText: 'Gallons Filled'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                String userId = widget.userId;
                String vehicleId = widget.vehicleID;
                addGasFillUp(userId, vehicleId);
                costController.clear();
                milesController.clear();
                gallonsController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add Gas Fill-Up'),
            ),
          ],
        ),
      ),
    );
  }
}
