import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'status_screen.dart';
import 'calls_screen.dart';

class HomeScreen extends StatelessWidget {
  final tabs = [
    StatusScreen(),
    ChatScreen(),
    CallsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("KamiChat"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Status"),
              Tab(text: "Chats"),
              Tab(text: "Calls"),
            ],
          ),
        ),
        body: TabBarView(children: tabs),
      ),
    );
  }
}