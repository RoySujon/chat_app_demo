import 'package:chat_app_demo/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //Get instance of FirebaseAuth and FireStore
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  //Send Message
  Future<void> sendMessage(
      {required String reciverID, required String message}) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //Create New Message
    Message newMessage = Message(
        message: message,
        senderEmail: currentUserEmail,
        senderID: currentUserId,
        reciverID: reciverID,
        timestamp: timestamp);

    List<String> ids = [currentUserId, reciverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    //Add a message in FirebaseDatabase

    _fireStore
        .collection('chat_room')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //Get Message
  Stream<QuerySnapshot> getMessage(
      {required String userID, required String otherUserID}) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");
    return _fireStore
        .collection('chat_room')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
