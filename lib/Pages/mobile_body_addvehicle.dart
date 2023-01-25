import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MobileBodyAddVehicle extends StatefulWidget {
  const MobileBodyAddVehicle({Key? key}) : super(key: key);
  @override
  _MobileBodyAddVehicleState createState() => _MobileBodyAddVehicleState();
}

class _MobileBodyAddVehicleState extends State<MobileBodyAddVehicle> {
  // Key used for client side textform validation
  final _formKey = GlobalKey<FormState>();

  //Data related properties
  final _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String? userId;

  //Variables to set defualts and manage button interactions and design
  bool sedanSelected = true;

  bool blackCarSelected = true;
  bool blueCarSelected = false;
  bool greenCarSelected = false;
  bool greyCarSelected = false;
  bool redCarSelected = false;
  bool whiteCarSelected = false;

  String carSelectedColor = "Black";
  String carSelectedImage = "assets/images/sedans/blacksedan.png";
  String carSelectedType = "sedan";

  //Assigned car colors defualt images - Changed by list values later
  String blackCar = "assets/images/sedans/blacksedan.png";
  String blueCar = "assets/images/sedans/bluesedan.png";
  String greenCar = "assets/images/sedans/greensedan.png";
  String greyCar = "assets/images/sedans/greysedan.png";
  String redCar = "assets/images/sedans/redsedan.png";
  String whiteCar = "assets/images/sedans/whitesedan.png";

  //Lists populated to access by car and color easily
  final List<String> _sedansImages = <String>[
    "assets/images/sedans/blacksedan.png",
    "assets/images/sedans/bluesedan.png",
    "assets/images/sedans/greensedan.png",
    "assets/images/sedans/greysedan.png",
    "assets/images/sedans/redsedan.png",
    "assets/images/sedans/whitesedan.png",
  ];

  final List<String> _suvImages = <String>[
    "assets/images/suvs/blacksuv.png",
    "assets/images/suvs/bluesuv.png",
    "assets/images/suvs/greensuv.png",
    "assets/images/suvs/greysuv.png",
    "assets/images/suvs/redsuv.png",
    "assets/images/suvs/whitesuv.png",
  ];

  //Textfield controllers to store entered text
  final TextEditingController _vehicleEnteredName = TextEditingController();
  final TextEditingController _vehicleEnteredMiles = TextEditingController();

  //Push new vehicle to database
  void addNewVehicle() async {
    final newVehicle = {
      'Name': _vehicleEnteredName.text,
      'AvgMiles': 0,
      'Color': carSelectedColor,
      'FillUps': 0,
      'Image': carSelectedImage,
      'Miles': int.parse(_vehicleEnteredMiles.text),
      'Type': carSelectedType,
      'User': userId
    };

    //Create unique vehicle key to avoid conflicts with duplicate names
    final newVehicleKey = ref.push().key;

    //Map to insert vehicle data with key
    final Map<String, Map> vehicleData = {};

    //Add new vehicle data to map under new key
    vehicleData['/Vehicles/$userId/$newVehicleKey'] = newVehicle;

    //Attempt to insert to database
    try {
      return ref.update(vehicleData);
    } on Exception catch (e) {
      print(e);
    }
  }

  //Grab userID to user later when inserting new vehicle
  void getCurrenUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        userId = user.uid;
      }
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
              title: const Text('My Garage'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            const ListTile(
              title: Text('Add Vehicle'),
              onTap: null,
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                _auth.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text('Select Car Color',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.5,
                ),
                items: [
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Opacity(
                      opacity: blackCarSelected ? 1.0 : .2,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            carSelectedColor = "Black";
                            carSelectedImage = blackCar;

                            blackCarSelected = true;
                            blueCarSelected = false;
                            greenCarSelected = false;
                            greyCarSelected = false;
                            redCarSelected = false;
                            whiteCarSelected = false;
                          });
                        },
                        icon: Image.asset(blackCar),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Opacity(
                      opacity: blueCarSelected ? 1.0 : 0.2,
                      child: IconButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            carSelectedColor = "Blue";
                            carSelectedImage = blueCar;

                            blackCarSelected = false;
                            blueCarSelected = true;
                            greenCarSelected = false;
                            greyCarSelected = false;
                            redCarSelected = false;
                            whiteCarSelected = false;
                          });
                        },
                        icon: Image.asset(blueCar),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Opacity(
                      opacity: greenCarSelected ? 1.0 : 0.2,
                      child: IconButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: (() {
                          setState(() {
                            carSelectedColor = "Green";
                            carSelectedImage = greenCar;

                            blackCarSelected = false;
                            blueCarSelected = false;
                            greenCarSelected = true;
                            greyCarSelected = false;
                            redCarSelected = false;
                            whiteCarSelected = false;
                          });
                        }),
                        icon: Image.asset(greenCar),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Opacity(
                      opacity: greyCarSelected ? 1.0 : 0.2,
                      child: IconButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: () {
                          setState(() {
                            carSelectedColor = "Grey";
                            carSelectedImage = greyCar;

                            blackCarSelected = false;
                            blueCarSelected = false;
                            greenCarSelected = false;
                            greyCarSelected = true;
                            redCarSelected = false;
                            whiteCarSelected = false;
                          });
                        },
                        icon: Image.asset(greyCar),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Opacity(
                      opacity: redCarSelected ? 1.0 : 0.2,
                      child: IconButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: (() {
                          setState(() {
                            carSelectedColor = "Red";
                            carSelectedImage = redCar;

                            blackCarSelected = false;
                            blueCarSelected = false;
                            greenCarSelected = false;
                            greyCarSelected = false;
                            redCarSelected = true;
                            whiteCarSelected = false;
                          });
                        }),
                        icon: Image.asset(redCar),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 175,
                    width: 175,
                    child: Opacity(
                      opacity: whiteCarSelected ? 1.0 : 0.2,
                      child: IconButton(
                        padding: const EdgeInsets.all(10),
                        onPressed: (() {
                          setState(() {
                            carSelectedColor = "White";
                            carSelectedImage = whiteCar;

                            blackCarSelected = false;
                            blueCarSelected = false;
                            greenCarSelected = false;
                            greyCarSelected = false;
                            redCarSelected = false;
                            whiteCarSelected = true;
                          });
                        }),
                        icon: Image.asset(whiteCar),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 8.0),
                  child: Text('Selected Color: $carSelectedColor',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Vehicle Type',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: sedanSelected ? Colors.green : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                      child: TextButton(
                        onPressed: (() {
                          setState(() {
                            sedanSelected = true;
                            carSelectedType = "sedan";
                            carSelectedImage =
                                "assets/images/sedans/${carSelectedColor.toLowerCase()}sedan.png";

                            blackCar = _sedansImages[0];
                            blueCar = _sedansImages[1];
                            greenCar = _sedansImages[2];
                            greyCar = _sedansImages[3];
                            redCar = _sedansImages[4];
                            whiteCar = _sedansImages[5];
                          });
                        }),
                        child: const Text('Sedan',
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ),
                    ),
                  ),
                  Container(
                    color: sedanSelected ? Colors.grey : Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
                      child: TextButton(
                        onPressed: (() {
                          setState(() {
                            sedanSelected = false;
                            carSelectedType = 'suv';
                            carSelectedImage =
                                "assets/images/suvs/${carSelectedColor.toLowerCase()}suv.png";

                            blackCar = _suvImages[0];
                            blueCar = _suvImages[1];
                            greenCar = _suvImages[2];
                            greyCar = _suvImages[3];
                            redCar = _suvImages[4];
                            whiteCar = _suvImages[5];
                          });
                        }),
                        child: const Text('SUV',
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
              child: TextFormField(
                controller: _vehicleEnteredName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Vehicle Name',
                ),
                validator: (String? value) {
                  return value!.isEmpty ? 'Enter a vehicle name' : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 4, 15, 4),
              child: TextFormField(
                controller: _vehicleEnteredMiles,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Current Vehicle Miles',
                ),
                validator: (String? value) {
                  return int.tryParse(value!) == null
                      ? 'Enter a valid whole number'
                      : null;
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.green,
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            addNewVehicle();

                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Add To Garage',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
