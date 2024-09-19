import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> _getMessage() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    log(token!);
  }

  @override
  void initState() {
    _getMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebasAuth = GetIt.I.get<FirebaseAuth>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чаты'),
        actions: [
          IconButton(
            onPressed: () {
              firebasAuth.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          const NewMessage(),
        ],
      ),
    );
  }
}
