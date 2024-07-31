import 'package:tuncbooking/model/conversation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/app_constants.dart';

class InboxViewModel {
  getConversations() {
    return FirebaseFirestore.instance
        .collection('conversations')
        .where('userIDs', arrayContains: AppConstants.currentUser.id)
        .snapshots();
  }

  getMessages(ConversationModel? conversation) {
    return FirebaseFirestore.instance
        .collection('conversations/${conversation!.id}/messages')
        .orderBy('dateTime')
        .snapshots();
  }
}
