// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tuncbooking/core/app_constants.dart';
import 'package:tuncbooking/global.dart';
import 'package:tuncbooking/model/conversation_model.dart';
import 'package:tuncbooking/model/message_model.dart';
import 'package:tuncbooking/view/widgets/widgets.dart';

class ConversationScreen extends StatefulWidget {
  static String routeName = "/conversation";
  ConversationModel? conversation;

  ConversationScreen({
    super.key,
    this.conversation,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ConversationModel? conversation;
  TextEditingController controller = TextEditingController();

  sendMessage() {
    String text = controller.text;

    if (text.isEmpty) {
      return;
    }

    conversation!.addMessageToFirestore(text).whenComplete(() {
      setState(() {
        controller.text = "";
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    conversation = widget.conversation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        backgroundColor: Colors.black,
        title: Text(
          conversation!.otherContact!.getFullNameOfUser(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: inboxViewModel.getMessages(conversation),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot snapshot = snapshots.data!.docs[index];
                      MessageModel currentMessage = MessageModel();
                      currentMessage.getMessageInfoFromFirestore(snapshot);

                      if (currentMessage.sender!.id ==
                          AppConstants.currentUser.id) {
                        currentMessage.sender =
                            AppConstants.currentUser.createContactFromUser();
                      } else {
                        currentMessage.sender = conversation!.otherContact;
                      }

                      return MessageListTileUI(
                        message: currentMessage,
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black,
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 5 / 6,
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'Write a message',
                        contentPadding: EdgeInsets.all(20.0),
                        border: InputBorder.none),
                    minLines: 1,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 20.0),
                    controller: controller,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
