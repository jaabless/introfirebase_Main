import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:introfirebase/introModels/UserModel.dart';
import 'package:introfirebase/introModels/user.dart';
import 'package:introfirebase/introScreens/home/chat_screens.dart';

class SerachScreen extends StatefulWidget {
  const SerachScreen({Key? key}) : super(key: key);

  @override
  State<SerachScreen> createState() => _SerachScreenState();
}

class _SerachScreenState extends State<SerachScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;
  User? user1 = FirebaseAuth.instance.currentUser;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No User Found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if (user.data()['uid'] != user1) {
          print(user1!.uid.toString());
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 177, 120),
        title: Text("Search your Doctor"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    // onChanged: (value) {
                    //   print('text $value');
                    //   searchController.text = value;
                    // },
                    controller: searchController,
                    // textCapitalization: Text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: "type username....",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          if (searchResult.length > 0)
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          // child: Image.network(searchResult[index]['image']),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 44, 51, 56),
                            ),
                            child: Icon(
                              Icons.supervised_user_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(searchResult[index]['name']),
                        subtitle: Text(searchResult[index]['date']),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.text = "";
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            currentUser: user1,
                                            friendId: searchResult[index]
                                                ['uid'],
                                            friendName: searchResult[index]
                                                ['name'],
                                            // friendImage: Image.asset(
                                            //     'assets/image/splash')
                                          )));
                            },
                            icon: Icon(Icons.message)),
                      );
                    }))
          else if (isLoading == true)
            Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
