import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gara/Api/web_scraper_api.dart';
import 'package:gara/Pages/home_page.dart';
import 'package:gara/Pages/new_accounts_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Data/Provider/car_data.dart';
import '../Data/Provider/car_data_provider.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  Future loadCarMakeAndModels(BuildContext context) async {
    final cacheManager = DefaultCacheManager();
    final cacheFile = await cacheManager.getSingleFile('map_cache');

    Map<String, List<String>> makeAndModels = {};

    if (cacheFile.existsSync() && cacheFile.lengthSync() > 0) {
      makeAndModels = await retrieveAndDecodeMap();
      print('Map retrieved successfully!');
    } else {
      makeAndModels = await WebScraperApi().getCarMakeAndModels();
      cacheMap(makeAndModels);
    }

    final carData = CarData(carMakeAndModels: makeAndModels);
    context.read<CarDataProvider>().setCarData(carData);
  }

  void cacheMap(Map<String, List<String>> myMap) async {
    final cacheManager = DefaultCacheManager();
    final jsonString = jsonEncode(myMap);
    final Uint8List jsonBytes = Uint8List.fromList(utf8.encode(jsonString));

    await cacheManager.putFile(
      'map_cache',
      jsonBytes,
      key: 'map_cache',
    );
    print('Map cached successfully!');
  }

  Future<Map<String, List<String>>> retrieveAndDecodeMap() async {
    final cacheManager = DefaultCacheManager();
    final cacheFile = await cacheManager.getSingleFile('map_cache');

    final Uint8List cachedData = await cacheFile.readAsBytes();
    final jsonString = utf8.decode(cachedData);
    final decodedMap = jsonDecode(jsonString) as Map<String, dynamic>;

    final Map<String, List<String>> resultMap = {};
    decodedMap.forEach((key, value) {
      if (value is List<dynamic>) {
        resultMap[key] = List<String>.from(value);
      }
    });

    return resultMap;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('GARA', style: GoogleFonts.poiretOne(fontSize: 110)),
                    const Padding(
                      padding: EdgeInsets.all(25),
                      child: Image(
                        image: AssetImage(
                          'assets/images/garage.png',
                        ),
                        height: 190,
                        width: 190,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Email"),
                              controller: _emailTextController,
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(_emailTextController.text)
                                    ? null
                                    : 'Enter a valid email address';
                              },
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Password"),
                              obscureText: true,
                              controller: _passwordTextController,
                              validator: (value) {
                                return _passwordTextController.text.isEmpty
                                    ? 'Enter your Password'
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 250,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text)
                                      .then((value) async => {
                                            _emailTextController.clear(),
                                            _passwordTextController.clear(),
                                            await loadCarMakeAndModels(context),
                                            Navigator.of(context).popUntil(
                                                (route) => route.isFirst),
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MobileBodyHome()))
                                          });
                                } on FirebaseAuthException {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            actions: [
                                              TextButton(
                                                child: const Text('Okay'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                            title: const Text('Error'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(
                                                      'Unable to login. Please try again later'),
                                                ],
                                              ),
                                            ),
                                          ));
                                }
                              }
                            },
                            child: const Text('Login',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have a garage yet?  "),
                            InkWell(
                              child: const Text('Sign Up',
                                  style: TextStyle(color: Colors.blue)),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const NewAccounts(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
