import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> _carSelection = <String>[
  'Mercedes GLK 350',
  'Chevy Trailblazor LTZ'
];

class MobileBody extends StatefulWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  String dropdownValue = _carSelection.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Text('Xăng'),
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('assets/images/canister.png'),
          ),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Image(
                image: AssetImage(
                  'assets/images/car.png',
                ),
                height: 250,
                width: 250,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[350],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5.0, 5.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: SizedBox(
                //Contains Car details
                height: 400,
                child: Column(
                  children: [
                    Center(
                      //Car selection
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                iconSize: 0,
                                alignment: Alignment.center,
                                underline: Container(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                                dropdownColor: Colors.green,
                                value: dropdownValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: _carSelection
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Miles:', style: TextStyle(fontSize: 20)),
                              Text('150000', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Divider(
                              height: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Avg Miles:',
                                  style: TextStyle(fontSize: 20)),
                              Text('324.5', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Divider(
                              height: 2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Fill Ups:', style: TextStyle(fontSize: 20)),
                              Text('22', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Divider(
                              height: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
