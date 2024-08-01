import 'package:tuncbooking/model/contact_model.dart';
import 'package:tuncbooking/model/posting_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String id = "";
  PostingModel? posting;
  ContactModel? contact;
  List<DateTime>? dates;

  BookingModel();

  getBookingInfoFromFirestoreFromPosting(
      PostingModel posting, DocumentSnapshot snapshot) async {
    posting = posting;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates']);

    dates = [];
    for (var timestamp in timestamps) {
      dates!.add((timestamp.toDate()));
    }

    String contactID = snapshot['userID'] ?? "";
    String fullName = snapshot['name'] ?? "";

    _loadContactInfo(id, fullName);

    contact = ContactModel(id: contactID);
  }

  _loadContactInfo(String id, String fullName) {
    String firstName = "";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];

    contact = ContactModel(id: id, firstName: firstName, lastName: lastName);
  }

  createBooking(
      PostingModel postingM, ContactModel contactM, List<DateTime> datesM) {
    posting = postingM;
    contact = contactM;
    dates = datesM;

    dates!.sort();
  }
}
