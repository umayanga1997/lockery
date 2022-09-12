import 'package:lockery_app/models/models.dart';

class RackModel {
  String? id;
  String? name;
  LocationModel? rackLocation;

  RackModel({this.id, this.name, this.rackLocation});

  RackModel.fromJson(dynamic json) {
    id = json['rack_id'];
    name = json['rack_name'];
    rackLocation = LocationModel.fromJson(json['rack_location']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rack_id'] = id;
    data['rack_name'] = name;
    data['rack_location'] = rackLocation!.toJson();
    return data;
  }
}
