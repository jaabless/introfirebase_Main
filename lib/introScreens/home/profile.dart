import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introfirebase/introScreens/home/settings_form.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

class ViewProfile extends StatefulWidget {
  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String dropdownvalue = 'Select Gender';
  var items = [
    'Select Gender',
    'Male',
    'Female',
    'Others',
    'Prefer not to say',
  ];
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState((() => this.image = imageTemporary));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user1 = FirebaseAuth.instance.currentUser;
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    void popImage(ImageSource source) async {
      var response = await pickImage(source);
      if (response == null) {
        Navigator.pop(context);
      }
      print({response: 'today'});
    }

    void _showImageSettings() {
      showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () {
                        popImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallery'),
                      // onTap: () => pickImage(ImageSource.gallery),
                      onTap: () {
                        popImage(ImageSource.gallery);
                      }),
                ],
              ));
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color.fromARGB(255, 6, 177, 120),
          actions: [
            FlatButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () {
                _showSettingsPanel();
              },
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spacer(),
            image != null
                ? ClipOval(
                    child: Image.file(
                      image!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  )
                : FlutterLogo(size: 160),
            SizedBox(
              height: 5,
            ),
            FlatButton.icon(
              label: Text('Change Image'),
              icon: Icon(Icons.edit),
              onPressed: () {
                _showImageSettings();
              },
            ),
            // Center(
            //   child: CircleAvatar(
            //     backgroundImage: AssetImage('assets/images/splash.png'),
            //     radius: 40.0,
            //   ),
            // ),
            Divider(
              height: 60.0,
              color: Colors.grey[800],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user1!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    var userData = asyncSnapshot.data;
                    return SingleChildScrollView(
                      child: Column(children: [
                        TextFormField(
                          initialValue: userData['name'],
                          // controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Enter your name',
                              enabled: false,
                              icon: Icon(Icons.person)),
                        ),
                        TextFormField(
                          initialValue: userData['email'],
                          // controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Enter your Email',
                              enabled: false,
                              icon: Icon(Icons.email)),
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
                            enabled: false,
                            hintText: 'Enter your Phone',
                          ),
                        ),
                        // dropdown
                        TextFormField(
                          initialValue: userData['gender'],
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusColor: Colors.black,
                            icon: Icon(Icons.male),
                            labelText: 'Gender',
                            enabled: false,
                            hintText: 'Enter your Phone',
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                      ]),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            SizedBox(
              height: 10.0,
            ),
            // Text(
            //   'Jeffery',
            //   style: TextStyle(
            //     color: Color.fromARGB(255, 160, 29, 29),
            //     letterSpacing: 2.0,
            //     fontSize: 20.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 30.0),

            // RaisedButton(
            //     child: Text('Pick Image'),
            //     color: Color.fromARGB(255, 6, 177, 120),
            //     onPressed: () => pickImage(ImageSource.gallery)),
            // RaisedButton(
            //     child: Text('Pick Image from Camera'),
            //     color: Color.fromARGB(255, 6, 177, 120),
            //     onPressed: () => pickImage(ImageSource.camera)),
            // SettingsList(
            //   sections: [
            //     SettingsSection(
            //       title: Text('Account'),
            //       tiles: <SettingsTile>[
            //         SettingsTile.navigation(
            //           leading: Icon(Icons.phone),
            //           title: Text('Phone number'),
            //           value: Text('0245323651'),
            //           trailing: Icon(Icons.edit),
            //         ),
            //         SettingsTile.navigation(
            //           leading: Icon(Icons.mail),
            //           title: Text('Email'),
            //           value: Text('asamoah123@gmail.com'),
            //         ),
            //         SettingsTile.navigation(
            //           leading: Icon(Icons.info),
            //           title: Text('About'),
            //           value: Text('asamoah123@gmail.com'),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
