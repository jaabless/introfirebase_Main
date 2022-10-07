import 'package:flutter/material.dart';
import 'package:introfirebase/introModels/UserModel.dart';

class UserTile extends StatelessWidget {
  // const UserTile({ Key? key }) : super(key: key);
  final usermodel user;
  UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 29.0, 9.0),
        child: ListTile(
          leading: CircleAvatar(radius: 25.0, backgroundColor: Colors.brown),
          title: Text(user.name),
          subtitle: Text('Name ${user.name} sugar(s)'),
        ),
      ),
    );
  }
}
// class messageTile extends StatelessWidget {
//   // final Message message;
//   messageTile({this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         child: ListTile(
//           leading: CircleAvatar(
//             backgroundColor: Colors.amber,
//             radius: 25.0,
//           ),
//           title: Text(message.name),
//           subtitle: Text('hello'),
//         ),
//       ),
//     );
//   }
// }
