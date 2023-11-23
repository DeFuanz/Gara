import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class CarImages {
  static String get blackCar => _carImages[0];
  static String get blueCar => _carImages[1];
  static String get greenCar => _carImages[2];
  static String get greyCar => _carImages[3];
  static String get redCar => _carImages[4];
  static String get whiteCar => _carImages[5];

  static List<String> get sedansImages => _carImages.sublist(0, 6);
  static List<String> get suvImages => _carImages.sublist(6, 12);

  static List<String> _carImages = [
    "assets/images/sedans/blacksedan.png",
    "assets/images/sedans/bluesedan.png",
    "assets/images/sedans/greensedan.png",
    "assets/images/sedans/greysedan.png",
    "assets/images/sedans/redsedan.png",
    "assets/images/sedans/whitesedan.png",
    "assets/images/suvs/blacksuv.png",
    "assets/images/suvs/bluesuv.png",
    "assets/images/suvs/greensuv.png",
    "assets/images/suvs/greysuv.png",
    "assets/images/suvs/redsuv.png",
    "assets/images/suvs/whitesuv.png",
  ];
}

class MobileBodyAddVehicle extends StatefulWidget {
  const MobileBodyAddVehicle({Key? key}) : super(key: key);
  @override
  _MobileBodyAddVehicleState createState() => _MobileBodyAddVehicleState();
}

class _MobileBodyAddVehicleState extends State<MobileBodyAddVehicle> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String? userId;

  bool sedanSelected = true;

  bool blackCarSelected = true;
  bool blueCarSelected = false;
  bool greenCarSelected = false;
  bool greyCarSelected = false;
  bool redCarSelected = false;
  bool whiteCarSelected = false;

  String carSelectedColor = "Black";
  String carSelectedImage = CarImages.blackCar;
  String carSelectedType = "sedan";

  late List<String> carImages;

  final TextEditingController _vehicleEnteredName = TextEditingController();
  final TextEditingController _vehicleEnteredMiles = TextEditingController();

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

    final newVehicleKey = ref.push().key;
    final Map<String, Map> vehicleData = {};
    vehicleData['/Vehicles/$userId/$newVehicleKey'] = newVehicle;

    try {
      return ref.update(vehicleData);
    } on Exception catch (e) {
      print(e);
    }
  }

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
    carImages = sedanSelected ? CarImages.sedansImages : CarImages.suvImages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('GARA',
            style: GoogleFonts.poiretOne(fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Select Car Color',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
                    _buildColorCarouselItem(
                        carImages[0], blackCarSelected, 'Black'),
                    _buildColorCarouselItem(
                        carImages[1], blueCarSelected, 'Blue'),
                    _buildColorCarouselItem(
                        carImages[2], greenCarSelected, 'Green'),
                    _buildColorCarouselItem(
                        carImages[3], greyCarSelected, 'Grey'),
                    _buildColorCarouselItem(
                        carImages[4], redCarSelected, 'Red'),
                    _buildColorCarouselItem(
                        carImages[5], whiteCarSelected, 'White'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4.0, 0, 8.0),
                    child: Text(
                      'Selected Color: $carSelectedColor',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Vehicle Type',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: sedanSelected ? Colors.green : Colors.grey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 2, 40, 2),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              sedanSelected = true;
                              carSelectedType = "sedan";
                              carSelectedImage =
                                  "assets/images/sedans/${carSelectedColor.toLowerCase()}sedan.png";

                              carImages = CarImages.sedansImages;
                            });
                          },
                          child: const Text(
                            'Sedan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: sedanSelected ? Colors.grey : Colors.green),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 2, 40, 2),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              sedanSelected = false;
                              carSelectedType = 'suv';
                              carSelectedImage =
                                  "assets/images/suvs/${carSelectedColor.toLowerCase()}suv.png";

                              carImages = CarImages.suvImages;
                            });
                          },
                          child: const Text(
                            'SUV',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 4, 15, 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.green,
                    ),
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addNewVehicle();
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorCarouselItem(
      String imageUrl, bool isSelected, String color) {
    return SizedBox(
      height: 175,
      width: 175,
      child: Opacity(
        opacity: isSelected ? 1.0 : 0.2,
        child: IconButton(
          onPressed: () {
            setState(() {
              carSelectedColor = color;
              carSelectedImage = imageUrl;

              blackCarSelected = color == 'Black';
              blueCarSelected = color == 'Blue';
              greenCarSelected = color == 'Green';
              greyCarSelected = color == 'Grey';
              redCarSelected = color == 'Red';
              whiteCarSelected = color == 'White';
            });
          },
          icon: Image.asset(imageUrl),
        ),
      ),
    );
  }
}
