import 'package:chat_app_demo/view/chat_scren.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!.email.toString()),
        actions: [
          IconButton(
              onPressed: () async => await FirebaseAuth.instance.signOut(),
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs
                  .map((e) =>
                      FirebaseAuth.instance.currentUser!.email != e['email']
                          ? Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            reciverUserID: e['uid'],
                                            reciverUserEmail: e['email']),
                                      ));
                                },
                                title: Text(e['email']),
                              ),
                            )
                          : SizedBox())
                  .toList(),
            );
          } else {
            return Text('Loading...');
          }
        },
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
      ),
    );
  }
}
