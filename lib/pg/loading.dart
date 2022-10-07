import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// class loading extends StatefulWidget {
//   const loading({Key? key}) : super(key: key);

//   @override
//   _loadingState createState() => _loadingState();
// }

// class _loadingState extends State<loading> {
//   // void getData() {
//   //   Future.delayed(Duration(seconds: 2), () {
//   //     Navigator.pushReplacementNamed(context, '/home');
//   //   });
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getData();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SpinKitRotatingCircle(
//           color: Color.fromARGB(255, 15, 15, 14),
//           size: 50.0,
//         ),
//       ),
//     );
//   }
// }

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitRotatingCircle(
          color: Color.fromARGB(255, 197, 197, 69),
          size: 50.0,
        ),
      ),
    );
  }
}
