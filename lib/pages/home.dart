import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  int amount = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // theme: ThemeData(          // Add the 5 lines from here...
      //   appBarTheme: const AppBarTheme(
      //     backgroundColor: Colors.white,
      //     foregroundColor: Colors.black,
      //   ),
      // ),
      appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text(
            "MTN Home",
            style: TextStyle(
              fontSize: 26.0,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _navbar,
              tooltip: 'more',
            )
          ]),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter Your Name',
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                )),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('Display1'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Text"),
                        content: Text(
                            "Username: ${nameController.text} \nPassword: ${passwordController.text}"),
                      );
                    });
              },
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                  "Welcome to MTN Portal \nYour remaining balance is Ghs: $amount "),
            ),
          ],
        ),
        // child: SpinKitRotatingCircle(
        //   color: Colors.red,
        //   size: 50.0,
        // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            amount += 1;
          });
        },
        child: Text(
          "Top Up",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
      ),
    );
  }

  List<String> options = [
    'Balance',
    'Check',
    'Help',
    'Balance',
    'Check',
    'Help'
  ];

  void _navbar() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      // final tiles =  ListTile(
      //   title: Text(options.toString()),
      //   trailing: Icon(
      //     Icons.check,
      //     color: Colors.black,
      //   ),
      // );

      return Scaffold(
          appBar: AppBar(
            title: const Text('Option'),
          ),
          body: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 4.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        if (options[index] == options[0]) {
                          Navigator.pushNamed(context, '/balance');
                        } else if (options[index] == options[2]) {
                          Navigator.pushNamed(context, '/help');
                        } else {
                          Navigator.pop(context, '/');
                        }
                      },
                      title: Text(options[index]),
                      leading: const Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }));
    }));
  }
}
