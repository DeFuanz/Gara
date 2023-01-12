import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileBodyAddVehicle extends StatefulWidget {
  const MobileBodyAddVehicle({Key? key}) : super(key: key);
  @override
  _MobileBodyAddVehicleState createState() => _MobileBodyAddVehicleState();
}

class _MobileBodyAddVehicleState extends State<MobileBodyAddVehicle> {
  final _auth = FirebaseAuth.instance;

  bool sedanSelected = true;

  bool blackCarSelected = true;
  bool blueCarSelected = false;
  bool greenCarSelected = false;
  bool greyCarSelected = false;
  bool redCarSelected = false;
  bool whiteCarSelected = false;

  String carSelectedColor = "Black";

  String carSelectedImage = "assets/images/sedans/blacksedan.png";
  int totalMilesInput = 0;
  String carSelectedType = "sedan";

  String blackCar = "assets/images/sedans/blacksedan.png";
  String blueCar = "assets/images/sedans/bluesedan.png";
  String greenCar = "assets/images/sedans/greensedan.png";
  String greyCar = "assets/images/sedans/greysedan.png";
  String redCar = "assets/images/sedans/redsedan.png";
  String whiteCar = "assets/images/sedans/whitesedan.png";

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

  Future addNewVehicle() async {
    final newVehicleData = {
      'AvgMiles': 0,
      'Color': carSelectedColor,
      'FillUps': 0,
      'Image': carSelectedImage,
      'Miles': totalMilesInput,
      'Type': carSelectedType
    };

    try {} on Exception catch (e) {
      print(e);
    }
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('Select Car Color',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              Opacity(
                opacity: blackCarSelected ? 1.0 : .2,
                child: IconButton(
                  padding: const EdgeInsets.all(10),
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
              Opacity(
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
              Opacity(
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
              Opacity(
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
              Opacity(
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
              Opacity(
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
            ],
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

                          blackCar = _sedansImages[0];
                          blueCar = _sedansImages[1];
                          greenCar = _sedansImages[2];
                          greyCar = _sedansImages[3];
                          redCar = _sedansImages[4];
                          whiteCar = _sedansImages[5];
                        });
                      }),
                      child: const Text('Sedan',
                          style: TextStyle(color: Colors.black, fontSize: 12)),
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

                          blackCar = _suvImages[0];
                          blueCar = _suvImages[1];
                          greenCar = _suvImages[2];
                          greyCar = _suvImages[3];
                          redCar = _suvImages[4];
                          whiteCar = _suvImages[5];
                        });
                      }),
                      child: const Text('SUV',
                          style: TextStyle(color: Colors.black, fontSize: 12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Vehicle Name',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Current Vehicle Miles',
              ),
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
                      onPressed: null,
                      child: Text(
                        'Add To Garage',
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
