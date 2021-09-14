
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Messages extends StatelessWidget {
  final String chatRoomId;
  Messages(this.chatRoomId);
  @override
  Widget build(BuildContext context) {
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat').document(chatRoomId).collection('messages')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(chatSnapshot.data.documents[index].data['userpicurl']),
                      radius: 20,
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatSnapshot.data.documents[index].data['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            chatSnapshot.data.documents[index].data['createdAt'].toDate().toString().split('.').first,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(chatSnapshot.data.documents[index].data['text'],),
                  );
                }
              );
            });
      }
  }
