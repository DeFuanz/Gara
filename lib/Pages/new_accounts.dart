import 'package:flutter/material.dart';

class NewAccounts extends StatefulWidget {
  const NewAccounts({Key? key}) : super(key: key);
  _NewAccountsState createState() => _NewAccountsState();
}

class _NewAccountsState extends State<NewAccounts> {
  final TextEditingController _emailTextcontroller = TextEditingController();
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
        body: Center(
          child: Column(
            children: [
              const Text('Create a New Account'),
              const Text('Email'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _emailTextcontroller,
                    decoration:
                        const InputDecoration(hintText: 'Enter your email'),
                    validator: (value) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(_emailTextcontroller.text)
                          ? null
                          : 'Enter a valid email address';
                    },
                  ),
                ),
              ),
              const Text('Password'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _password1Controller,
                    decoration:
                        const InputDecoration(hintText: 'Enter a password'),
                    validator: (value) {
                      return _password1Controller.text.length < 8
                          ? 'Password must be at least 8 character'
                          : null;
                    },
                  ),
                ),
              ),
              const Text('Enter Password Again'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _password2Controller,
                    decoration:
                        const InputDecoration(hintText: 'Enter your email'),
                    validator: (value) {
                      return _password2Controller != _password1Controller
                          ? 'Passwords do not match. Please try again'
                          : null;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Create Account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
