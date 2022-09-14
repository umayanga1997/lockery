import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockery_app/models/models.dart';
import 'package:lockery_app/screens/payment.dart';
import 'package:lockery_app/services/services.dart';
import 'package:lockery_app/widgets/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController? cameraController;

  bool isAlert = false;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  Future askPermission() async {
    try {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        await Permission.camera.request().then((value) {
          setState(() {});
        });
      }
    } catch (e) {
      //
    }
  }

  void showResponse(BuildContext context, BookedIDsDataModel data) {
    try {
      setState(() {
        isAlert = true;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Respose'),
            content: FutureBuilder<DocumentSnapshot>(
              future: lockersCollection.doc(data.lockerId).get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(height: 50, child: Progressor());
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                }

                LockerModel lockerData = LockerModel.fromJson(snapshot.data);

                return lockerData.lockerId == null
                    ? const Center(
                        child: Text('Locker was not found!'),
                      )
                    : lockerData.isAvailable!
                        ? SizedBox(
                            height: 150,
                            width: 150,
                            child: LockerCard(lockerModel: lockerData),
                          )
                        : lockerData.isClosed! &&
                                !lockerData.isLocked! // Default Mode
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomButton(
                                    icon: Icons.key,
                                    label: "Open Your Locker",
                                    onPressed: () {
                                      lockersCollection
                                          .doc(lockerData.lockerId)
                                          .update({
                                        'isClosed': false,
                                        'isLocked': true,
                                      }).then((value) {
                                        successMessage(
                                            message: 'Locker has been opened!');
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                  CustomButton(
                                    icon: Icons.cancel,
                                    label: "Release the Locker",
                                    onPressed: () {
                                      lockersCollection
                                          .doc(lockerData.lockerId)
                                          .update({
                                        'isClosed': true,
                                        'isLocked': false,
                                        'isAvailable': true,
                                        'bookedDataEncode': null,
                                        'final_booked_date': null,
                                        'final_end_date': null,
                                      }).then((value) {
                                        successMessage(
                                            message:
                                                'Locker has been released!');
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ],
                              )
                            : !lockerData.isClosed! && lockerData.isLocked!
                                ? CustomButton(
                                    icon: Icons.lock_open,
                                    label: "Close Your Locker",
                                    onPressed: () {
                                      lockersCollection
                                          .doc(lockerData.lockerId)
                                          .update({
                                        'isClosed': true,
                                      }).then((value) {
                                        successMessage(
                                            message: 'Locker has been closed!');
                                        Navigator.pop(context);
                                      });
                                    },
                                  )
                                : lockerData.isClosed! &&
                                        lockerData.isLocked! // Payment Mode
                                    ? CustomButton(
                                        icon: Icons.payment,
                                        label: "Payment",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(data: data),
                                            ),
                                          ).then((value) =>
                                              Navigator.pop(context));
                                        },
                                      )
                                    : const SizedBox.shrink();
              },
            ),
          );
        },
      ).then((value) {
        setState(() {
          isAlert = false;
        });
      });
    } catch (e) {
      errorMessage(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    cameraController = MobileScannerController();
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: cameraController,
              allowDuplicates: true,
              onDetect: (barcode, args) {
                try {
                  if (!isAlert) {
                    if (barcode.rawValue == null) {
                      errorMessage(message: "The QR code is an error!");
                    } else {
                      // Set data to model
                      BookedIDsDataModel data = BookedIDsDataModel.fromJson(
                          jsonDecode(barcode.rawValue!));

                      if (data != (null)) {
                        showResponse(context, data);
                      } else {
                        errorMessage(message: "The QR code is invalid!");
                      }
                    }
                  }
                } catch (e) {
                  // errorMessage(message: 'Invalid QR\n$e');
                }
              },
            ),
          ),
          QRScannerOverlay(
            overlayColour: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
