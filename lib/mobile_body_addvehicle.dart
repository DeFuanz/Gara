import 'package:flutter/material.dart';

class MobileBodyAddVehicle extends StatefulWidget {
  const MobileBodyAddVehicle({Key? key}) : super(key: key);
  _MobileBodyAddVehicleState createState() => _MobileBodyAddVehicleState();
}

class _MobileBodyAddVehicleState extends State<MobileBodyAddVehicle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text('Add new vehicle'),
    );
  }
}
