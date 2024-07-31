import 'package:tuncbooking/viewmodel/inbox_view_model.dart';
import 'package:tuncbooking/viewmodel/posting_view_model.dart';
import 'package:tuncbooking/viewmodel/user_view_model.dart';

import 'model/posting_model.dart';

PostingModel postingModel = PostingModel();
UserViewModel userViewModel = UserViewModel();
PostingViewModel postingViewModel = PostingViewModel();
InboxViewModel inboxViewModel = InboxViewModel();

String paymentResult = "";
double? bookingPrice = 0.0;
String hostID = "";
