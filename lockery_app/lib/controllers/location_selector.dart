import 'package:flutter/cupertino.dart';
import 'package:lockery_app/helpers/helpers.dart';
import 'package:lockery_app/models/locations.dart';

class LocationSelectController extends ChangeNotifier {
  LocationModel currentValue = locations[0];
  void changeLocation(LocationModel value) {
    currentValue = value;
    notifyListeners();
  }
}
