import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:introfirebase/introScreens/home/userTile.dart';
import 'package:introfirebase/introModels/UserModel.dart';

class messageList extends StatefulWidget {
  const messageList({Key? key}) : super(key: key);

  @override
  State<messageList> createState() => _messageListState();
}

class _messageListState extends State<messageList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<usermodel>?>(context);
    // messages?.forEach((user) {
    //   print(user.name);
    //   print(user.hospitalNumber);
    //   print(user.gender);
    // });

    // for (var doc in messages!.docs) {
    //   print(doc.data());
    // }
    // print(messages.docs);
    print("hi");
    return ListView.builder(
      itemCount: users?.length,
      itemBuilder: (context, index) {
        return UserTile(user: users![index]);
      },
    );
  }
}
