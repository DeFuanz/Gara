import 'package:choring/Features/VehicleListHome/Presentation/MobilePages/mobile_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAccounts extends StatefulWidget {
  const NewAccounts({Key? key}) : super(key: key);
  @override
  _NewAccountsState createState() => _NewAccountsState();
}

class _NewAccountsState extends State<NewAccounts> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: (() => Navigator.pop(context)),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.green,
              )),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Create a New Account',
                        style: GoogleFonts.poiretOne(
                            textStyle: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: const [
                      Flexible(
                        child: Text(
                          'We just need a few things to get your garage set up!',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('Email',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      TextFormField(
                        controller: _emailTextController,
                        decoration: InputDecoration(
                            hintText: 'example@gara.com',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_emailTextController.text)
                              ? null
                              : 'Enter a valid email address';
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('Password',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      TextFormField(
                        controller: _password1Controller,
                        decoration: InputDecoration(
                            hintText: '8 or more characters',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          return _password1Controller.text.length < 8
                              ? 'Password must be at least 8 character'
                              : null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text('Retype Password',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      TextFormField(
                        controller: _password2Controller,
                        decoration: InputDecoration(
                            hintText: 'Enter Password Again',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        validator: (value) {
                          return _password2Controller.text !=
                                  _password1Controller.text
                              ? 'Passwords do not match. Please try again'
                              : null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _password1Controller.text)
                              .then((value) => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MobileBodyHome()))
                                  });
                        }
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
