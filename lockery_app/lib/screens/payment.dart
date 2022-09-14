import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lockery_app/models/booked_ids_data.dart';
import 'package:lockery_app/services/firebase.dart';
import 'package:lockery_app/services/message.dart';
import 'package:lockery_app/widgets/custom_button.dart';
import 'package:lockery_app/widgets/progressor.dart';

class PaymentScreen extends StatefulWidget {
  final BookedIDsDataModel data;
  const PaymentScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = true;
  double amount = 0;

  @override
  void initState() {
    super.initState();
    initPaybleAmount();
  }

  void initPaybleAmount() {
    try {
      bookedCollection.doc(widget.data.bookingId).get().then((value) {
        if (value.data() != null) {
          amount = value.data()!['total_price'] ?? 0;
        }
      }).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      errorMessage(message: e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: isLoading
              ? const Progressor()
              : CustomButton(
                  icon: Icons.payments,
                  label: "Pay Rs.${amount.toStringAsFixed(2)}",
                  onPressed: () {
                    try {
                      // Update locker status
                      lockersCollection.doc(widget.data.lockerId).update({
                        'isClosed': true,
                        'isLocked': false,
                        'isAvailable': true,
                        'bookedDataEncode': null,
                        'final_booked_date': null,
                        'final_end_date': null,
                      }).then((value) {
                        successMessage(message: 'Payment successfull!');
                        Navigator.pop(context);
                      });
                    } catch (e) {
                      errorMessage(message: e.toString());
                    }
                  },
                ),
        ),
      ),
    );
  }
}
