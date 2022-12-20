import 'package:choring/mobile_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Xăng',
                style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            Padding(
              padding: const EdgeInsets.all(25),
              child: const Image(
                image: AssetImage(
                  'assets/images/canister.png',
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
                    TextField(
                      decoration: InputDecoration(hintText: "Email"),
                      controller: _emailTextController,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Password"),
                      obscureText: true,
                      controller: _passwordTextController,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MobileBody()))
                          });
                },
                child: Text('Login', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: const TextButton(
                onPressed: null,
                child: Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
