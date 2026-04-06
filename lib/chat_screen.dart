import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AppServices service = AppServices();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: service.getMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text("Loading..."));
              var docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, i) {
                  bool isMe = docs[i]['senderId'] == service.auth.currentUser?.uid;
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.greenAccent : Colors.grey[800],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(docs[i]['text'], style: TextStyle(color: Colors.black)),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: (_) => service.setTyping(true),
                onSubmitted: (_) => service.setTyping(false),
                decoration: InputDecoration(hintText: "Type a message..."),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                service.sendMessage(controller.text);
                controller.clear();
                service.setTyping(false);
              },
            ),
          ],
        )
      ],
    );
  }
}