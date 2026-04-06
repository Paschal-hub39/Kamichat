import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  final controller = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  void sendMessage() {
    if (controller.text.isEmpty) return;

    firestore.collection('messages').add({
      'text': controller.text,
      'time': FieldValue.serverTimestamp(),
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: firestore
                .collection('messages')
                .orderBy('time')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text("Loading..."));

              var docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      docs[i]['text'],
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
              );
            },
          ),
        ),

        Row(
          children: [
            Expanded(child: TextField(controller: controller)),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: sendMessage,
            ),
          ],
        )
      ],
    );
  }
}
