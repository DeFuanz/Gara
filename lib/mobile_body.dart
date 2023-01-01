import 'package:choring/mobile_body_addvehicle.dart';
import 'package:choring/mobile_body_addvehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Models/Vehicle.dart';

class MobileBodyHome extends StatefulWidget {
  const MobileBodyHome({Key? key}) : super(key: key);

  @override
  State<MobileBodyHome> createState() => _MobileBodyHomeState();
}

class _MobileBodyHomeState extends State<MobileBodyHome> {
  String miles = "0";
  String avgMiles = "0";
  String fillUps = "0";
  String colour = "";
  String image = "assets/images/car.png";
  final List<Vehicle> _vehicleList = <Vehicle>[];
  Vehicle? dropdownValue;

  late final vehicleFuture;

  //create firebase instance variable and new user object variable
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  //Grabbed logged in user object
  void getCurrenUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(user.uid);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  //grab users vehicle objects from db
  Future getVehicles() async {
    try {
      final vehicleSnapshot = await dbRef.child('Vehicles').get();

      for (var v in vehicleSnapshot.children) {
        Vehicle vehicle = Vehicle();
        vehicle.vehicleName = v.key.toString();
        vehicle.avgMiles = int.parse(v.children.elementAt(0).value.toString());
        vehicle.color = v.children.elementAt(1).value.toString();
        vehicle.fillUps = int.parse(v.children.elementAt(2).value.toString());
        vehicle.vehicleImage = v.children.elementAt(3).value.toString();
        vehicle.totalMiles =
            int.parse(v.children.elementAt(4).value.toString());
        vehicle.vehicleType = v.children.elementAt(5).value.toString();
        _vehicleList.add(vehicle);
      }

      dropdownValue = _vehicleList.first;
      miles = _vehicleList.first.totalMiles.toString();
      fillUps = _vehicleList.first.fillUps.toString();
      avgMiles = _vehicleList.first.avgMiles.toString();
      colour = _vehicleList.first.color.toString();
      image = _vehicleList.first.vehicleImage.toString();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrenUser();
    vehicleFuture = getVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: vehicleFuture,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            foregroundColor: Colors.green,
            backgroundColor: Colors.white,
            title: const Center(child: Text('Xăng')),
            leading: const Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage('assets/images/canister.png'),
              ),
            ),
          ),
          endDrawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Add Vehicle'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MobileBodyAddVehicle(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    _auth.signOut();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage(
                      image,
                    ),
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: SizedBox(
                    //Contains Car details
                    height: 320,
                    child: Column(
                      children: [
                        Center(
                          //Car selection
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    hint: const Text("Select a vehicle"),
                                    iconSize: 0,
                                    alignment: Alignment.center,
                                    underline: Container(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    dropdownColor: Colors.green,
                                    value: dropdownValue,
                                    onChanged: (Vehicle? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;

                                        miles = newValue.totalMiles.toString();
                                        avgMiles = newValue.avgMiles.toString();
                                        fillUps = newValue.fillUps.toString();
                                        image =
                                            newValue.vehicleImage.toString();
                                      });
                                    },
                                    items: _vehicleList
                                        .map<DropdownMenuItem<Vehicle>>(
                                            (Vehicle value) {
                                      return DropdownMenuItem<Vehicle>(
                                        value: value,
                                        child:
                                            Text(value.vehicleName.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text('Miles:',
                                      style: TextStyle(fontSize: 20)),
                                  Text(miles,
                                      style: const TextStyle(fontSize: 20)),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: const Divider(
                                  height: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text('Avg Miles:',
                                      style: TextStyle(fontSize: 20)),
                                  Text(avgMiles,
                                      style: const TextStyle(fontSize: 20)),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: const Divider(
                                  height: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text('Fill Ups:',
                                      style: TextStyle(fontSize: 20)),
                                  Text(fillUps,
                                      style: const TextStyle(fontSize: 20)),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: const Divider(
                                  height: 2,
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
            ],
          ),
        );
      },
    );
  }
}
