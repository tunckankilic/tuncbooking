import 'package:tuncbooking/core/app_constants.dart';
import 'package:tuncbooking/model/booking_model.dart';
import 'package:tuncbooking/model/contact_model.dart';
import 'package:tuncbooking/model/conversation_model.dart';
import 'package:tuncbooking/model/posting_model.dart';
import 'package:tuncbooking/model/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserModel extends ContactModel {
  String? email;
  String? password;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isCurrentlyHosting;
  DocumentSnapshot? snapshot;

  List<BookingModel>? bookings;
  List<ReviewModel>? reviews;

  List<PostingModel>? savedPostings;
  List<PostingModel>? myPostings;

  UserModel({
    String super.id,
    String super.firstName,
    String super.lastName,
    super.displayImage,
    this.email = "",
    this.bio = "",
    this.city = "",
    this.country = "",
  }) {
    isHost = false;
    isCurrentlyHosting = false;

    bookings = [];
    reviews = [];

    savedPostings = [];
    myPostings = [];
  }

  createContactFromUser() {
    return ContactModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      displayImage: displayImage,
    );
  }

  addPostingToMyPostings(PostingModel posting) async {
    myPostings!.add(posting);

    List<String> myPostingIDsList = [];

    for (var element in myPostings!) {
      myPostingIDsList.add(element.id!);
    }

    await FirebaseFirestore.instance.collection("users").doc(id).update({
      'myPostingIDs': myPostingIDsList,
    });
  }

  getMyPostingsFromFirestore() async {
    List<String> myPostingIDs = List<String>.from(snapshot!["myPostingIDs"]);

    for (String postingID in myPostingIDs) {
      PostingModel posting = PostingModel(id: postingID);
      await posting.getPostingInfoFromFirestore();
      await posting.getAllBookingsFromFirestore();
      await posting.getAllImagesFromStorage();

      myPostings!.add(posting);
    }
  }

  addSavedPosting(PostingModel posting) async {
    for (var savedPosting in savedPostings!) {
      if (savedPosting.id == posting.id) {
        return;
      }
    }

    savedPostings!.add(posting);

    List<String> savedPostingIDs = [];

    for (var savedPosting in savedPostings!) {
      savedPostingIDs.add(savedPosting.id!);
    }

    await FirebaseFirestore.instance.collection("users").doc(id).update({
      'savedPostingIDs': savedPostingIDs,
    });

    Get.snackbar("Marked as Favorite", "Saved to your Favorite List.");
  }

  removeSavedPosting(PostingModel posting) async {
    for (int i = 0; i < savedPostings!.length; i++) {
      if (savedPostings![i].id == posting.id) {
        savedPostings!.removeAt(i);
        break;
      }
    }

    List<String> savedPostingIDs = [];

    for (var savedPosting in savedPostings!) {
      savedPostingIDs.add(savedPosting.id!);
    }

    await FirebaseFirestore.instance.collection("users").doc(id).update({
      'savedPostingIDs': savedPostingIDs,
    });

    Get.snackbar("Listing Removed", "Listing removed from your Favorite List.");
  }

  Future<void> addBookingToFirestore(BookingModel booking,
      double totalPriceForAllNights, String hostID) async {
    Map<String, dynamic> data = {
      'dates': booking.dates,
      'postingID': booking.posting!.id!,
    };
    await FirebaseFirestore.instance
        .doc('users/$id/bookings/${booking.id}')
        .set(data);

    String earningsOld = "";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(hostID)
        .get()
        .then((dataSnap) {
      earningsOld = dataSnap["earnings"].toString();
    });

    await FirebaseFirestore.instance.collection("users").doc(hostID).update({
      "earnings": totalPriceForAllNights + double.parse(earningsOld),
    });
    bookings!.add(booking);

    await addBookingConversation(booking);
  }

  addBookingConversation(BookingModel booking) async {
    ConversationModel conversation = ConversationModel();
    conversation.addConversationToFirestore(booking.posting!.host!);

    String textMessage =
        "Hi my name is ${AppConstants.currentUser.firstName} and I have "
        "just booked ${booking.posting!.name} from ${booking.dates!.first} to "
        "${booking.dates!.last} if you have any questions contact me. Enjoy your "
        "stay!";

    await conversation.addMessageToFirestore(textMessage);
  }

  List<DateTime> getAllBookedDates() {
    List<DateTime> allBookedDates = [];

    for (var posting in myPostings!) {
      for (var booking in posting.bookings!) {
        allBookedDates.addAll(booking.dates!);
      }
    }

    return allBookedDates;
  }
}
