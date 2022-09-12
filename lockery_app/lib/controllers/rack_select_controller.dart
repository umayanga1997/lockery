import 'package:flutter/cupertino.dart';

class RackSelectController extends ChangeNotifier {
  String? rackID;
  void changeRack(String? value) {
    if (rackID != value) {
      rackID = value;
      notifyListeners();
    }
  }
}
