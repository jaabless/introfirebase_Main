import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:introfirebase/introModels/UserModel.dart';
import 'package:introfirebase/introModels/user.dart';
import 'package:introfirebase/introScreens/home/chat_screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:introfirebase/introScreens/widgets/message_textfielld.dart';
import 'package:introfirebase/introScreens/widgets/single_messages.dart';

class ChatScreen extends StatelessWidget {
  User? user1 = FirebaseAuth.instance.currentUser;
  final currentUser;
  final String friendId;
  final String friendName;
  // final friendImage;

  ChatScreen({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
    // required this.friendImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color.fromARGB(255, 6, 177, 120),
        title: Row(children: [
          ClipRect(
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
          SizedBox(
            width: 5,
          ),
          Text(
            friendName,
            style: TextStyle(fontSize: 20),
          )
        ]),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser.uid)
                    .collection('messages')
                    .doc(friendId)
                    .collection('chats')
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return Center(
                        child: Text("Say Hi"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          // var date = snapshot.data.docs[index]['date'];
                          var time = snapshot.data.docs[index]['time'];
                          bool isMe = snapshot.data.docs[index]['senderId'] ==
                              currentUser.uid;
                          return SingleMessage(
                            message: snapshot.data.docs[index]['message'],
                            isMe: isMe,
                            time: time,
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )),
          MessageTextField(user1!.uid, friendId)
        ],
      ),
    );
  }
}
