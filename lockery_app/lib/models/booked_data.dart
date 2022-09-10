class BookedDataModel {
  String? userId;
  String? bookingId;
  String? lockerId;

  BookedDataModel({this.userId, this.bookingId, this.lockerId});

  BookedDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    bookingId = json['booking_id'];
    lockerId = json['locker_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['booking_id'] = bookingId;
    data['locker_id'] = lockerId;
    return data;
  }
}
