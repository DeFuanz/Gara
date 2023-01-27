import 'dart:ui';

import 'package:choring/Features/VehicleListHome/Presentation/MobilePages/mobile_body.dart';
import 'package:choring/Features/CreateAccount/Presentation/MobilePages/new_accounts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            decoration:
                BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Gara',
                    style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Image(
                    image: AssetImage(
                      'assets/images/garage.png',
                    ),
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(hintText: "Email"),
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
                Container(
                  width: 200,
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
                                  password: _passwordTextController.text)
                              .then((value) => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MobileBodyHome()))
                                  });
                        } on FirebaseAuthException catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
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
                                              'Uable to login. Please try again later'),
                                        ],
                                      ),
                                    ),
                                  ));
                        }
                      }
                    },
                    child: const Text('Login',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.green)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NewAccounts(),
                      ));
                    },
                    child: const Text('Create Account',
                        style: TextStyle(color: Colors.green)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
