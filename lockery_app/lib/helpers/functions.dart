import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lockery_app/models/booked_data.dart';

bool isCurrentUserLocker(var value) {
  try {
    BookedDataModel data = BookedDataModel.fromJson(json.decode(value));
    return data.userId == FirebaseAuth.instance.currentUser!.uid;
  } catch (e) {
    return false;
  }
}
