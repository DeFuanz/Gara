
import 'package:gara/Pages/mobile_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

PreferredSizeWidget buildAppBar(BuildContext context) {
  FirebaseAuth _auth = FirebaseAuth.instance;

  return AppBar(
    elevation: 0,
    foregroundColor: Colors.green,
    backgroundColor: const Color.fromARGB(255, 252, 252, 252),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/images/garage.png'),
          height: 30, // adjust the height as needed
          width: 30, // adjust the width as needed
        ),
        const SizedBox(width: 10),
        Text(
          'GARA',
          style: GoogleFonts.poiretOne(fontWeight: FontWeight.bold),
        ),
      ],
    ),
    leading: Navigator.of(context).canPop()
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        : IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.grey,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          _auth.signOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const MobileLogin(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
  );
}
