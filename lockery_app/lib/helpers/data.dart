import 'package:lockery_app/models/models.dart';

String jtwSecret = 'appoftwt';

List<LocationModel> locations = [
  LocationModel(id: 0, name: 'All'),
  LocationModel(id: 1, name: 'Colombo'),
  LocationModel(id: 2, name: 'Kandy'),
  LocationModel(id: 3, name: 'Bandarawela'),
  LocationModel(id: 4, name: 'Badulla'),
  LocationModel(id: 5, name: 'Nuwara Eliya'),
  LocationModel(id: 6, name: 'Jaffna'),
  LocationModel(id: 7, name: 'Negombo'),
  LocationModel(id: 8, name: 'Awissawella'),
  LocationModel(id: 9, name: 'Kurunegala'),
  LocationModel(id: 10, name: 'Wellawaya'),
];

List<RackModel> racks = [
  RackModel(
    id: 'rack_1',
    name: 'Rack 01',
    rackLocation: locations[1],
  ),
  RackModel(
    id: 'rack_2',
    name: 'Rack 02',
    rackLocation: locations[2],
  ),
  RackModel(
    id: 'rack_3',
    name: 'Rack 03',
    rackLocation: locations[3],
  ),
  RackModel(
    id: 'rack_4',
    name: 'Rack 04',
    rackLocation: locations[4],
  ),
  RackModel(
    id: 'rack_5',
    name: 'Rack 05',
    rackLocation: locations[5],
  ),
  RackModel(
    id: 'rack_6',
    name: 'Rack 06',
    rackLocation: locations[6],
  ),
  RackModel(
    id: 'rack_7',
    name: 'Rack 07',
    rackLocation: locations[7],
  ),
  RackModel(
    id: 'rack_8',
    name: 'Rack 08',
    rackLocation: locations[8],
  ),
  RackModel(
    id: 'rack_9',
    name: 'Rack 09',
    rackLocation: locations[9],
  ),
];

List<LockerModel> lockers = [
  LockerModel(
    lockerId: 'locker_1',
    lockerName: 'Locker 01',
    rackId: 'rack_1',
    bookedDataEncode: '',
    isAvailable: true,
    isClosed: false,
    isLocked: false,
  ),
  LockerModel(
    lockerId: 'locker_2',
    lockerName: 'Locker 02',
    rackId: 'rack_2',
    bookedDataEncode: '',
    isAvailable: false,
    isClosed: true,
    isLocked: false,
  ),
  LockerModel(
    lockerId: 'locker_3',
    lockerName: 'Locker 03',
    rackId: 'rack_3',
    bookedDataEncode: '',
    isAvailable: false,
    isClosed: false,
    isLocked: true,
  ),
  LockerModel(
    lockerId: 'locker_4',
    lockerName: 'Locker 04',
    rackId: 'rack_4',
    bookedDataEncode: '',
    isAvailable: true,
    isClosed: false,
    isLocked: false,
  ),
  LockerModel(
    lockerId: 'locker_5',
    lockerName: 'Locker 05',
    rackId: 'rack_5',
    bookedDataEncode: '',
    isAvailable: false,
    isClosed: false,
    isLocked: true,
  ),
  LockerModel(
    lockerId: 'locker_6',
    lockerName: 'Locker 06',
    rackId: 'rack_6',
    bookedDataEncode: '',
    isAvailable: true,
    isClosed: false,
    isLocked: false,
  ),
  LockerModel(
    lockerId: 'locker_7',
    lockerName: 'Locker 07',
    rackId: 'rack_7',
    bookedDataEncode: '',
    isAvailable: false,
    isClosed: true,
    isLocked: false,
  ),
  LockerModel(
    lockerId: 'locker_8',
    lockerName: 'Locker 08',
    rackId: 'rack_8',
    bookedDataEncode: '',
    isAvailable: false,
    isClosed: false,
    isLocked: true,
  ),
  LockerModel(
    lockerId: 'locker_9',
    lockerName: 'Locker 09',
    rackId: 'rack_9',
    bookedDataEncode: '',
    isAvailable: true,
    isClosed: false,
    isLocked: false,
  ),
];
