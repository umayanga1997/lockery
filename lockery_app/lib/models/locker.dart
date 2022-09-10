import 'package:lockery_app/models/locations.dart';

class LockerModel {
  String? lockerId;
  String? lockerName;
  LocationModel? lockerLocation;
  String? bookedDataEncode;
  bool? isAvailable;
  bool? isLocked;
  bool? isOpened;

  LockerModel(
      {this.lockerId,
      this.lockerName,
      this.lockerLocation,
      this.bookedDataEncode,
      this.isAvailable,
      this.isLocked,
      this.isOpened});

  LockerModel.fromJson(dynamic json) {
    lockerId = json['locker_id'];
    lockerName = json['locker_name'];
    lockerLocation = LocationModel.fromJson(json['locker_location']);
    bookedDataEncode = json['bookedDataEncode'];
    isAvailable = json['isAvailable'];
    isLocked = json['isLocked'];
    isOpened = json['isClosed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locker_id'] = lockerId;
    data['locker_name'] = lockerName;
    data['locker_location'] = lockerLocation!.toJson();
    data['bookedDataEncode'] = bookedDataEncode;
    data['isAvailable'] = isAvailable;
    data['isLocked'] = isLocked;
    data['isClosed'] = isOpened;
    return data;
  }
}
