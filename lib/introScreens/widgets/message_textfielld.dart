import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:introfirebase/introScreens/authenticate/register.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField(this.currentId, this.friendId);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    // String hr = date.hour.toString();
    // String min = date.minute.toString();
    // String time = '$hr' + ':' + '$min';
    var formatTime = DateFormat('kk:mm');
    String time = formatTime.format(date);

    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.all(8),
      child: Form(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: "Type your message",
                    fillColor: Colors.grey[100],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                validator: validateText,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                String message = _controller.text;
                _controller.clear();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .collection('chats')
                    .add({
                  "senderId": widget.currentId,
                  "receiverId": widget.friendId,
                  "message": message,
                  "type": "text",
                  "date": date,
                  "time": time,
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .set({'last_msg': message, 'time': time});
                });

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.friendId)
                    .collection('messages')
                    .doc(widget.currentId)
                    .collection("chats")
                    .add({
                  "senderId": widget.currentId,
                  "receiverId": widget.friendId,
                  "message": message,
                  "type": "text",
                  "date": date,
                  "time": time,
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.friendId)
                      .collection('messages')
                      .doc(widget.currentId)
                      .set({"last_msg": message, 'time': time});
                });
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 6, 177, 120)),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String? validateText(String? forMessageField) {
  if (forMessageField == null || forMessageField.isEmpty)
    return 'Filed is empty';

  return null;
}
