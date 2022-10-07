import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introfirebase/pg/loading.dart';
import 'package:introfirebase/introServices/auth.dart';
// import 'package:introfirebase/pg/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  // final passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;
  bool _toogleVisibility = true;
  String erMsg = " ";

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return isLoading
        ? Loading()
        : MaterialApp(
            home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 6, 177, 120),
              title: Text('Logged ' + (user == null ? 'out' : 'in')),
              actions: <Widget>[
                // FlatButton.icon(
                //   icon: Icon(Icons.person),
                //   label: Text('Sign Up'),
                //   onPressed: () => widget.toggleView(),
                // ),
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 150,
                            // decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //     image: NetworkImage('https://play-lh.googleusercontent.com/cF_oWC9Io_I9smEBhjhUHkOO6vX5wMbZJgFpGny4MkMMtz25iIJEh2wASdbbEN7jseAx=w240-h480')),
                            //     borderRadius: BorderRadius.circular(50.0)),
                            child: Image.asset('assets/images/chat.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter Your Email',
                          ),
                          validator: validateEmail,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 15, bottom: 0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _toogleVisibility,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toogleVisibility = !_toogleVisibility;
                                });
                              },
                              icon: _toogleVisibility
                                  ? const Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      size: 20,
                                    ),
                            ),
                            labelText: 'Password',
                            hintText: 'Must be at least 8 characters',
                          ),
                          validator: validatePassword,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          //TODO FORGOT PASSWORD SCREEN GOES HERE
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Color.fromARGB(255, 6, 177, 120),
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 6, 177, 120),
                            borderRadius: BorderRadius.circular(20)),
                        child: FlatButton(
                            child: Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            onPressed: user != null
                                ? null
                                : () async {
                                    if (_key.currentState!.validate()) {
                                      try {
                                        setState(() {
                                          isLoading = true;
                                          errorMessage = '';
                                        });
                                        dynamic result = await AuthService()
                                            .registerWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                        errorMessage = '';
                                      } on FirebaseAuthException catch (error) {
                                        errorMessage = error.message!;
                                      }
                                      setState(() => isLoading = false);
                                    }
                                  }),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Already have an account?'),
                      FlatButton(
                        onPressed: () => widget.toggleView(),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: Color.fromARGB(255, 6, 177, 120),
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
      Password must be at least 8 characters,
      include an uppercase letter, number and symbol.
      ''';

  return null;
}

showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 73, 73, 73),
      textColor: Colors.white,
      fontSize: 16.0);
}
