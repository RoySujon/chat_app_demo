import 'dart:math';

import 'package:chat_app_demo/components/custome_text_field.dart';
import 'package:chat_app_demo/view_model/auth_service/auth_services.dart';
import 'package:chat_app_demo/view_model/chat_service/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {super.key, required this.reciverUserID, required this.reciverUserEmail});
  final String reciverUserID, reciverUserEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reciverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(2),
                            child: Column(
                              crossAxisAlignment: e['senderID'] ==
                                      FirebaseAuth.instance.currentUser!.uid
                                          .toString()
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                1.2),
                                    decoration: e['senderID'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                                .toString()
                                        ? const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                            color: Colors.brown,
                                          )
                                        : const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(0),
                                            ),
                                            color: Colors.black,
                                          ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      child: Text(
                                        e['message'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                          ))
                      .toList(),
                );
              } else {
                return Text("Loading...");
              }
            },
            stream: _chatService.getMessage(
                userID: reciverUserID,
                otherUserID: FirebaseAuth.instance.currentUser!.uid.toString()),
          )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                // obscureText: obscureText,
                controller: _messageContorller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Enter your Message',
                    filled: true,
                    fillColor: Colors.white,
                    // label: Text('Message'),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _messageContorller.text.trim().isNotEmpty
                            ? _chatService
                                .sendMessage(
                                    reciverID: reciverUserID,
                                    message: _messageContorller.text.toString())
                                .then((value) => _messageContorller.clear())
                            : null;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
              )),
        ],
      ),
    );
  }

  final _messageContorller = TextEditingController();
  final _chatService = ChatService();
}
