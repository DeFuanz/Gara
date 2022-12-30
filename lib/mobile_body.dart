import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Models/Vehicle.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  static const List<String> _carSelection = <String>[
    'Mercedes GLK 350',
    'Chevy Trailblazor LTZ'
  ];

  final List<Vehicle> _vehicleList = <Vehicle>[];
  late String? dropdownValue;

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
        print(user.email);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Vehicle vehicle = Vehicle();

  Future getVehicles() async {
    try {
      final vehicleSnapshot = await dbRef.child('Vehicles').get();

      for (var v in vehicleSnapshot.children) {
        Vehicle vehicle = Vehicle();
        vehicle.vehicleName = v.key.toString();
        vehicle.avgMiles = int.parse(v.children.elementAt(0).value.toString());
        vehicle.fillUps = int.parse(v.children.elementAt(1).value.toString());
        vehicle.totalMiles =
            int.parse(v.children.elementAt(2).value.toString());
        _vehicleList.add(vehicle);
      }
      dropdownValue = _vehicleList.first.vehicleName.toString();
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrenUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVehicles(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            foregroundColor: Colors.green,
            backgroundColor: Colors.white,
            title: const Text('Xăng'),
            leading: const Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage('assets/images/canister.png'),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/car.png',
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
                    height: 400,
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
                                    iconSize: 0,
                                    alignment: Alignment.center,
                                    underline: Container(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    dropdownColor: Colors.green,
                                    value: dropdownValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = value;
                                      });
                                    },
                                    items: _vehicleList
                                        .map<DropdownMenuItem<String>>(
                                            (Vehicle value) {
                                      return DropdownMenuItem<String>(
                                        value: value.vehicleName.toString(),
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
                                  const Text('150000',
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Divider(
                                  height: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Avg Miles:',
                                      style: TextStyle(fontSize: 20)),
                                  Text('324.5', style: TextStyle(fontSize: 20)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Divider(
                                  height: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Fill Ups:',
                                      style: TextStyle(fontSize: 20)),
                                  Text('22', style: TextStyle(fontSize: 20)),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                child: Divider(
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
