import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'widgets.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({super.key});

  final me = GetIt.I.get<FirebaseAuth>().currentUser!;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'У вас пока что нет сообщении',
              style: theme.textTheme.titleLarge,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Что то пошло не так...',
              style: theme.textTheme.titleLarge,
            ),
          );
        }

        final loadedMessages = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            reverse: true,
            itemCount: loadedMessages.length,
            itemBuilder: (context, index) {
              final chatMessage = loadedMessages[index];
              final nextChatMessage = index + 1 < loadedMessages.length
                  ? loadedMessages[index + 1]
                  : null;
              final chatMessageUserId = chatMessage['userId'];
              final nextChatMessageUserId =
                  nextChatMessage != null ? nextChatMessage['userId'] : null;
              final isSameUser = chatMessageUserId == nextChatMessageUserId;
              if (isSameUser) {
                return MessageBubble.next(
                  isMe: me.uid == nextChatMessageUserId,
                  message: chatMessage['message'],
                );
              } else {
                return MessageBubble.first(
                  userImage: chatMessage['imageUrl'],
                  username: chatMessage['username'],
                  message: chatMessage['message'],
                  isMe: me.uid == chatMessageUserId,
                );
              }
            },
          ),
        );
      },
    );
  }
}
