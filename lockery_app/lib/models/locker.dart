class LockerModel {
  String? lockerId;
  String? lockerName;
  String? rackId;
  String? bookedDataEncode;
  bool? isAvailable;
  bool? isLocked;
  bool? isClosed;

  LockerModel(
      {this.lockerId,
      this.lockerName,
      this.rackId,
      this.bookedDataEncode,
      this.isAvailable,
      this.isLocked,
      this.isClosed});

  LockerModel.fromJson(dynamic json) {
    lockerId = json['locker_id'];
    lockerName = json['locker_name'];
    rackId = json['rack_id'];
    bookedDataEncode = json['bookedDataEncode'];
    isAvailable = json['isAvailable'];
    isLocked = json['isLocked'];
    isClosed = json['isClosed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locker_id'] = lockerId;
    data['locker_name'] = lockerName;
    data['rack_id'] = rackId;
    data['bookedDataEncode'] = bookedDataEncode;
    data['isAvailable'] = isAvailable;
    data['isLocked'] = isLocked;
    data['isClosed'] = isClosed;
    return data;
  }
}
