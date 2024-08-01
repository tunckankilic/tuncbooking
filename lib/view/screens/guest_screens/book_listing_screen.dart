import 'package:flutter/foundation.dart';
import 'package:tuncbooking/global.dart';
import 'package:tuncbooking/model/posting_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/calender_ui.dart';

class BookListingScreen extends StatefulWidget {
  static String routeName = "/bookListing";

  PostingModel? posting;
  String? hostID;

  BookListingScreen({
    super.key,
    this.posting,
    this.hostID,
  });

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  PostingModel? posting;
  List<DateTime> bookedDates = [];
  List<DateTime> selectedDates = [];
  List<CalenderUI> calendarWidgets = [];

  _buildCalendarWidgets() {
    for (int i = 0; i < 12; i++) {
      calendarWidgets.add(CalenderUI(
        monthIndex: i,
        bookedDates: bookedDates,
        selectDate: _selectDate,
        getSelectedDates: _getSelectedDates,
      ));

      setState(() {});
    }
  }

  List<DateTime> _getSelectedDates() {
    return selectedDates;
  }

  _selectDate(DateTime date) {
    if (selectedDates.contains(date)) {
      selectedDates.remove(date);
    } else {
      selectedDates.add(date);
    }

    selectedDates.sort();

    setState(() {});
  }

  _loadBookedDates() {
    posting!.getAllBookingsFromFirestore().whenComplete(() {
      bookedDates = posting!.getAllBookedDates();
      _buildCalendarWidgets();
    });
  }

  _makeBooking() {
    if (selectedDates.isEmpty) {
      return;
    }

    posting!
        .makeNewBooking(selectedDates, context, widget.hostID)
        .whenComplete(() {
      Get.back();
    });
  }

  calculateAmountForOverAllStay() {
    if (selectedDates.isEmpty) {
      return;
    }

    double totalPriceForAllNights = selectedDates.length * posting!.price!;

    setState(() {
      bookingPrice = totalPriceForAllNights;
    });

    if (kDebugMode) {
      print("price = $bookingPrice");
    }
  }

  @override
  void initState() {
    super.initState();

    posting = widget.posting;
    _loadBookedDates();
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
        title: Text(
          "Book ${posting!.name}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Sun'),
                Text('Mon'),
                Text('Tues'),
                Text('Wed'),
                Text('Thur'),
                Text('Fri'),
                Text('Sat'),
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: (calendarWidgets.isEmpty)
                  ? Container()
                  : PageView.builder(
                      itemCount: calendarWidgets.length,
                      itemBuilder: (context, index) {
                        return calendarWidgets[index];
                      }),
            ),

            bookingPrice == 0.0
                ? MaterialButton(
                    onPressed: () {
                      calculateAmountForOverAllStay();
                    },
                    minWidth: double.infinity,
                    height: MediaQuery.of(context).size.height / 14,
                    color: Colors.green,
                    child: const Text(
                      'Proceed',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(),

            // paymentResult != ""
            //     ? MaterialButton(
            //         onPressed: ()
            //         {
            //           Get.to(GuestHomeScreen());

            //           setState(() {
            //             paymentResult = "";
            //           });
            //         },
            //         minWidth: double.infinity,
            //         height: MediaQuery.of(context).size.height / 14,
            //         color: Colors.green,
            //         child: const Text('Amount Paid Successfully', style: TextStyle(color: Colors.white),),
            //       )
            //     : Container(),

            // bookingPrice == 0.0 ? Container() :
            // Platform.isIOS
            //     ? ApplePayButton(
            //   paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
            //   paymentItems:
            //   [
            //     PaymentItem(
            //       label: 'Booking Amount',
            //       amount: bookingPrice.toString(),
            //       status: PaymentItemStatus.final_price,
            //     ),
            //   ],
            //   style: ApplePayButtonStyle.black,
            //   width: double.infinity,
            //   height: 50,
            //   type: ApplePayButtonType.buy,
            //   margin: const EdgeInsets.only(top: 15.0),
            //   onPaymentResult: (result)
            //   {
            //     print("Payment Result = $result");

            //     setState(() {
            //       paymentResult = result.toString();
            //     });

            //     _makeBooking();
            //   },
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // )
            //     : GooglePayButton(
            //   paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
            //   paymentItems:
            //   [
            //     PaymentItem(
            //       label: 'Total Amount',
            //       amount: bookingPrice.toString(),
            //       status: PaymentItemStatus.final_price,
            //     )
            //   ],
            //   type: GooglePayButtonType.pay,
            //   margin: const EdgeInsets.only(top: 15.0),
            //   onPaymentResult: (result)
            //   {
            //     print("Payment Result = $result");

            //     setState(() {
            //       paymentResult = result.toString();
            //     });

            //     _makeBooking();
            //   },
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
