import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  String time;
  SingleMessage(
      {required this.message, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
                color: isMe
                    ? Color.fromARGB(255, 2, 158, 106)
                    : Color.fromARGB(255, 133, 138, 141),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        SizedBox(),
        Text(
          '$time',
          style: TextStyle(fontSize: 12.5),
        )
      ],
    );
  }
}
