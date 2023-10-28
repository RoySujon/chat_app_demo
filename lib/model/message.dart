import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message, senderEmail, senderID, reciverID;

  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.senderEmail,
      required this.senderID,
      required this.reciverID,
      required this.timestamp});

//Convert to a Map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'reciverId': reciverID,
      'message': message,
      'timestamp': timestamp
    };
  }
}
