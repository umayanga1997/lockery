import 'package:flutter/cupertino.dart';

class RackSelectController extends ChangeNotifier {
  String? rackID;
  void changeLocation(String value) {
    rackID = value;
    notifyListeners();
  }
}
