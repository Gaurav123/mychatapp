import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mychatapp/widget/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final user = FirebaseAuth.instance.currentUser;
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data!.docs;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  (chatDocs[index].data() as dynamic) ['text'],
                  (chatDocs[index].data()as dynamic)!['username'],
                  (chatDocs[index].data() as dynamic)!['userImage'],
                  (chatDocs[index].data()as dynamic)['userId'] == user!.uid,
                  key: ValueKey(chatDocs[index].id),
                ),
              );
      },
    );
  }
}
