import 'package:flutter/material.dart';
import 'package:introfirebase/introModels/user.dart';
import 'package:introfirebase/introServices/database.dart';
import 'package:introfirebase/modelsNinja/user.dart';
import 'package:introfirebase/pages/loading.dart';
import 'package:introfirebase/pg/loading.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final List<String> gender = ['Male', 'Female'];
  TextEditingController nameController = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Select Gender';

  // List of items in our dropdown menu
  var items = [
    'Select Gender',
    'Male',
    'Female',
    'Others',
    'Prefer not to say',
  ];
  String _currentName = 'New User';
  String _currentEmail = 'user@email.com';
  String _currentPhone = '+233(0) 000 000000';
  String _currentGender = '';
  @override
  Widget build(BuildContext context) {
    User? user1 = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user1!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            var userData = asyncSnapshot.data;
            print("has data");
            return Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    'Update your profile.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData['name'],
                    // controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        icon: Icon(Icons.person)),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  // SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData['email'],
                    // controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter your Email',
                        icon: Icon(Icons.email)),
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter Email' : null,
                    onChanged: (val) => setState(() => _currentEmail = val),
                  ),
                  TextFormField(
                    initialValue: userData['phone'],
                    decoration: InputDecoration(
                      counterStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusColor: Colors.black,
                      icon: Icon(Icons.phone),
                      labelText: 'Phone',
                      hintText: 'Enter your Phone',
                    ),
                  ),
                  // dropdown
                  DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  RaisedButton(
                      color: Color.fromARGB(255, 6, 177, 120),
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          print('hi');
                          await DatabaseService(uid: user1.uid).updateUserData(
                              _currentName,
                              userData['hospital number'],
                              dropdownvalue,
                              userData['date'],
                              userData['uid'],
                              _currentEmail,
                              _currentPhone,
                              userData['image']);
                          Navigator.pop(context);
                        }
                      }),
                ]),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
