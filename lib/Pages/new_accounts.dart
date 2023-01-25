import 'package:flutter/material.dart';

class NewAccounts extends StatefulWidget {
  const NewAccounts({Key? key}) : super(key: key);
  _NewAccountsState createState() => _NewAccountsState();
}

class _NewAccountsState extends State<NewAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Create a New Account'),
            const Text('Email'),
            TextFormField(
              controller: null,
              decoration: const InputDecoration(hintText: 'Enter your email'),
            ),
            const Text('Password'),
            const Text('Enter Password Again'),
          ],
        ),
      ),
    );
  }
}
