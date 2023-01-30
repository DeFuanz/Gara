import 'package:flutter/material.dart';

class VehicleCard extends StatefulWidget {
  const VehicleCard({Key? key}) : super(key: key);
  _VehicleCardState createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(),
          ),
        ],
      ),
    );
  }
}
