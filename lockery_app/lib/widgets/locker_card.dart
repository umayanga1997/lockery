import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lockery_app/helpers/helpers.dart';
import 'package:lockery_app/models/models.dart';
import 'package:lockery_app/screens/payment.dart';
import 'package:lockery_app/services/services.dart';
import 'package:uuid/uuid.dart';

class LockerCard extends StatefulWidget {
  final LockerModel lockerModel;
  const LockerCard({Key? key, required this.lockerModel}) : super(key: key);

  @override
  State<LockerCard> createState() => _LockerCardState();
}

class _LockerCardState extends State<LockerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          try {
            if (widget.lockerModel.isLocked! &&
                isCurrentUserLocker(widget.lockerModel.bookedDataEncode)) {
              // Payment Page view
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentScreen(),
                ),
              );
            } else if (isCurrentUserLocker(
                widget.lockerModel.bookedDataEncode)) {
              successMessage(message: "The locker was booked by you!!");
            } else if (!widget.lockerModel.isAvailable!) {
              errorMessage(message: "The locker is not available!");
            } else {
              // Generate Booking Id
              const uuid = Uuid();
              var bookingId = uuid.v4();

              // Create Encode Data
              var encodeData = json.encode(BookedDataModel(
                userId: FirebaseAuth.instance.currentUser!.uid,
                bookingId: bookingId,
                lockerId: widget.lockerModel.lockerId!,
              ).toJson());

              // Update Locker
              lockersCollection.doc(widget.lockerModel.lockerId!).update({
                'isAvailable': false,
                // 'isClosed': true,
                // 'isLocked': false,
                'bookedDataEncode': encodeData,
                'final_booked_date': DateTime.now(),
                'final_end_date': DateTime.now().add(const Duration(days: 2)),
              }).then((value) {
                bookedCollection.doc(bookingId).set({
                  'booked_id': bookingId,
                  'bookedDataEncode': encodeData,
                  'booked_date': DateTime.now(),
                  'end_date': DateTime.now().add(const Duration(days: 2)),
                  'total_price': 1200.00,
                }).then((value) =>
                    successMessage(message: 'locker booking is successful!'));
              }).catchError((onError) => errorMessage(message: onError));
            }
          } catch (e) {
            errorMessage(message: e.toString());
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(
                      isCurrentUserLocker(widget.lockerModel.bookedDataEncode)
                          ? Icons.person
                          : Icons.work,
                      color: isCurrentUserLocker(
                              widget.lockerModel.bookedDataEncode)
                          ? mainColor
                          : widget.lockerModel.isAvailable!
                              ? greenColor
                              : redColor,
                    ),
                    Text(
                      widget.lockerModel.isAvailable!
                          ? 'Available'
                          : isCurrentUserLocker(
                                  widget.lockerModel.bookedDataEncode)
                              ? 'Your Locker'
                              : 'Not Available',
                      style: TextStyle(color: greyColor2),
                    )
                  ],
                ),
              ),
            ),
            isCurrentUserLocker(widget.lockerModel.bookedDataEncode)
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            widget.lockerModel.isLocked!
                                ? Icons.lock
                                : widget.lockerModel.isClosed!
                                    ? Icons.key
                                    : Icons.open_in_new_rounded,
                            size: 18,
                            color: widget.lockerModel.isLocked!
                                ? redColor
                                : greyColor1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              widget.lockerModel.isLocked!
                                  ? 'Locked'
                                  : widget.lockerModel.isClosed!
                                      ? 'Closed'
                                      : 'Opend',
                              style: TextStyle(
                                color: widget.lockerModel.isLocked!
                                    ? redColor
                                    : greyColor1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            Center(
              child: Text(
                widget.lockerModel.lockerName!,
                style: TextStyle(fontSize: xf, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
