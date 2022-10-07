import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introfirebase/introModels/chatmessageModel.dart';
import 'package:introfirebase/introScreens/home/messageList.dart';
import 'package:introfirebase/introServices/auth.dart';
import 'package:introfirebase/introServices/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:introfirebase/introScreens/home/messageList.dart';
// import 'package:introfirebase/pg/loading.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({Key? key}) : super(key: key);

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello", messageType: "receiver"),
    ChatMessage(messageContent: "Hi", messageType: "sender"),
    ChatMessage(messageContent: "how are you doing", messageType: "receiver"),
    ChatMessage(messageContent: "I'm good and you?", messageType: "sender"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 226, 226),
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            // actions: [
            //   FlatButton.icon(
            //     icon: Icon(Icons.person),
            //     label: Text('Logout'),
            //     onPressed: () async {
            //       await AuthService().signOut();
            //     },
            //   )
            // ],

            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/splash.png'),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dr. Kriss Benwat",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Color.fromARGB(255, 229, 227, 227),
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await AuthService().signOut();
                    },
                  )
                ]),
              ),
            )),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.grey.shade100
                                : Colors.blue),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ));
                }),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Write message...',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.blue,
                        elevation: 0,
                      )
                    ],
                  ),
                ))
          ],
        ));
  }
}
