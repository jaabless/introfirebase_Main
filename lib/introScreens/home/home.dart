import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:introfirebase/introScreens/home/chat_screens.dart';
import 'package:introfirebase/introScreens/home/messageList.dart';
import 'package:introfirebase/introScreens/home/profile.dart';
import 'package:introfirebase/introScreens/home/searchScreen.dart';
import 'package:introfirebase/introScreens/home/settings.dart';
import 'package:introfirebase/introScreens/home/settings_form.dart';
import 'package:introfirebase/introServices/auth.dart';
import 'package:introfirebase/introServices/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:introfirebase/introScreens/home/messageList.dart';
import 'package:introfirebase/introModels/UserModel.dart';
// import 'package:introfirebase/pg/loading.dart';

class homeAuth extends StatefulWidget {
  @override
  _homeAuthState createState() => _homeAuthState();
}

class _homeAuthState extends State<homeAuth> {
  @override
  Widget build(BuildContext context) {
    User? user1 = FirebaseAuth.instance.currentUser;
    final date = DateTime.now();
    String hr = date.hour.toString();
    String min = date.minute.toString();
    // var formatTime = DateFormat('kk:mm');
    // String time = formatTime.format(date);

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 6, 177, 120),
        actions: [
          // IconButton(
          //     onPressed: () async {
          //       await AuthService().signOut();
          //     },
          //     icon: Icon(Icons.logout)),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.more_vert),
          // ),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Text('Profile'),
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => ViewProfile()));
                // },
              ),
              // PopupMenuItem(
              //   value: 1,
              //   child: Text('Settings'),
              // ),
              PopupMenuItem(
                value: 1,
                child: Text('Settings'),
              ),
              PopupMenuItem(
                child: Text('Logout'),
                onTap: () async {
                  await AuthService().signOut();
                },
              )
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewProfile()));
            } else if (value == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppSettings()));
            }
            // else if (value == 2) {
            //   //   print('2');
            //   // }
          })
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user1!.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return Center(
                  child: Text("You Have No Chats Available !"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendId = snapshot.data.docs[index].id;
                    var time = snapshot.data.docs[index]['time'];
                    var lastMsg = snapshot.data.docs[index]['last_msg'];
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return Column(
                            children: [
                              Divider(
                                height: 12.0,
                              ),
                              ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  // child: CachedNetworkImage(
                                  //   imageUrl:friend['image'],
                                  //   placeholder: (conteext,url)=>CircularProgressIndicator(),
                                  //   errorWidget: (context,url,error)=>Icon(Icons.error,),
                                  //   height: 50,
                                  // ),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 44, 51, 56),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(friend['name']),
                                subtitle: Container(
                                  child: Text(
                                    "$lastMsg",
                                    style: TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: Text(
                                  '$time',
                                  style: TextStyle(fontSize: 12.5),
                                ),
                                //navigate to chat screen
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                currentUser: user1,
                                                friendId: friend['uid'],
                                                friendName: friend['name'],
                                              )));
                                },
                              ),
                            ],
                          );
                        }
                        return LinearProgressIndicator();
                      },
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 6, 177, 120),
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SerachScreen()));
        },
      ),
    );
  }
}
