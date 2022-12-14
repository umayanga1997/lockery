import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lockery_app/models/booked_ids_data.dart';

bool isCurrentUserLocker(var value) {
  try {
    BookedIDsDataModel data = BookedIDsDataModel.fromJson(json.decode(value));
    return data.userId == FirebaseAuth.instance.currentUser!.uid;
  } catch (e) {
    return false;
  }
}
